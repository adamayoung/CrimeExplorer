import CrimeExplorerCore
import MapKit
import SwiftUI

struct CrimeMapView: View {

    @EnvironmentObject private var model: AppModel
    @State private var showAnnotationLabels: Bool = false

    #if os(watchOS)
    @State private var isNavigationBarHidden = true
    #endif

    #if os(iOS)
    @State private var bottomSheetState: BottomSheetState = .closed
    #endif

    var body: some View {
        GeometryReader { geometry in
            #if os(watchOS)
            crimeMap
                .navigationBarHidden(isNavigationBarHidden)
            #else
            crimeMap
            #endif
            #if os(iOS)
            StreetCrimeSummarySheet(state: $bottomSheetState, height: geometry.size.height)
            #endif
        }
        .ignoresSafeArea()
    }

    @ViewBuilder private var crimeMap: some View {
        Map(coordinateRegion: $model.region,
            interactionModes: .all,
            showsUserLocation: true,
            userTrackingMode: $model.userTrackingMode,
            annotationItems: model.streetCrimeSummaries,
            annotationContent: annotation(for:)
        )
        .accessibility(label: Text("CRIMES"))
        .accessibility(identifier: "crimeMap")
        .onReceive(model.$region .throttle(for: .milliseconds(100), scheduler: DispatchQueue.main, latest: true),
                   perform: didUpdateRegion)
        .gesture(TapGesture(count: 1).onEnded(didTapMap))
    }

    private func annotation(for summary: StreetCrimeSummary) -> MapAnnotation<StreetCrimeSummaryMapMarker> {
        MapAnnotation(coordinate: summary.coordinate) {
            StreetCrimeSummaryMapMarker(summary: summary, showAnnotationLabels: showAnnotationLabels) {
                self.model.selectedStreetCrimeSummary = summary
            }
        }
    }

    private func didUpdateRegion(_ region: MKCoordinateRegion) {
        showAnnotationLabels = region.shouldAnnotationLabelsBeVisible
        #if os(iOS)
        bottomSheetState = .closed
        #endif
        #if os(watchOS)
        isNavigationBarHidden = false
        #endif
    }

    private func didTapMap() {
        #if os(watchOS)
        withAnimation {
            isNavigationBarHidden.toggle()
        }
        #endif
    }

}

struct CrimeMapView_Previews: PreviewProvider {

    static var previews: some View {
        CrimeMapView()
            .environmentObject(AppModel.mock)
            .previewDevice("iPhone 12 Pro")
    }

}
