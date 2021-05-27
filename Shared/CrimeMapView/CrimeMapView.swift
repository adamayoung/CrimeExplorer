import MapKit
import SwiftUI

struct CrimeMapView: View {

    @EnvironmentObject private var model: AppModel

    var body: some View {
        Map(coordinateRegion: $model.region, interactionModes: .all, showsUserLocation: true,
            userTrackingMode: $model.userTrackingMode, annotationItems: model.crimes) { crime in
            MapAnnotation(coordinate: crime.location.coordinate, anchorPoint: CGPoint(x: 0.5, y: 0.5)) {
                CrimeMapMarker(category: crime.category)
            }
        }
    }
}

struct CrimeMapView_Previews: PreviewProvider {

    static var previews: some View {
        CrimeMapView()
            .environmentObject(AppModel.mock)
    }

}
