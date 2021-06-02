import CrimeExplorerCore
import MapKit
import SwiftUI

struct CrimeMapView: View {

    @EnvironmentObject private var model: AppModel
    @State private var showAnnotationLabels: Bool = false

    #if os(iOS)
    @State private var bottomSheetState: BottomSheetState = .closed
    #endif

    var body: some View {
        GeometryReader { geometry in
            crimeMap
            #if os(iOS)
            StreetCrimeSummarySheet(
                state: $bottomSheetState,
                height: geometry.size.height
            )
            #endif
        }
        .ignoresSafeArea()
    }

    private var crimeMap: some View {
        Map(coordinateRegion: $model.region,
            interactionModes: .all,
            showsUserLocation: true,
            userTrackingMode: $model.userTrackingMode,
            annotationItems: model.streetCrimeSummaries
        ) {
            annotation(for: $0)
        }
        .accessibility(label: Text("CRIMES"))
        .accessibility(identifier: "crimeMap")
        .onReceive(model.$region.throttle(for: .milliseconds(100), scheduler: DispatchQueue.main, latest: true)) {
            showAnnotationLabels = $0.shouldAnnotationLabelsBeVisible
            #if os(iOS)
            bottomSheetState = .closed
            #endif
        }
    }

    private func annotation(for summary: StreetCrimeSummary) -> MapAnnotation<StreetCrimeSummaryMapMarker> {
        MapAnnotation(coordinate: summary.coordinate) {
            StreetCrimeSummaryMapMarker(summary: summary, showAnnotationLabels: showAnnotationLabels) {
                self.model.selectedStreetCrimeSummary = summary
            }
        }
    }

}

struct CrimeMapView_Previews: PreviewProvider {

    static var previews: some View {
        CrimeMapView()
            .environmentObject(AppModel.mock)
            .previewDevice("iPhone 12 Pro")
    }

}
