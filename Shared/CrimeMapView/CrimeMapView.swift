import MapKit
import SwiftUI

struct CrimeMapView: View {

    @EnvironmentObject private var model: AppModel

    var body: some View {
        Map(coordinateRegion: $model.region, showsUserLocation: true, userTrackingMode: $model.userTrackingMode)
    }
}

struct CrimeMapView_Previews: PreviewProvider {

    static var previews: some View {
        CrimeMapView()
            .environmentObject(AppModel.mock)
    }

}
