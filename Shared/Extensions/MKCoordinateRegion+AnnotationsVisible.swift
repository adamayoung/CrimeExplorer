import Foundation
import MapKit

extension MKCoordinateRegion {

    private static var visibleDelta: Double {
        0.14
    }

    var shouldAnnotationsBeVisible: Bool {
        span.latitudeDelta < Self.visibleDelta && span.longitudeDelta < Self.visibleDelta
    }

    func isWithin(distance: CLLocationDistance, of region: MKCoordinateRegion) -> Bool {
        let thisLocation = CLLocation(latitude: center.latitude, longitude: center.longitude)
        let otherLocation = CLLocation(latitude: region.center.latitude, longitude: region.center.longitude)
        return otherLocation.distance(from: thisLocation) < distance
    }

}
