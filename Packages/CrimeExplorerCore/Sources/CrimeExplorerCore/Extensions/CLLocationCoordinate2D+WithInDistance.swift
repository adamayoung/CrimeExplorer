import CoreLocation
import Foundation

extension CLLocationCoordinate2D {

    public func isWithin(_ distance: CLLocationDistance, of coordinate: CLLocationCoordinate2D) -> Bool {
        let thisLocation = CLLocation(latitude: latitude, longitude: longitude)
        let otherLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        return otherLocation.distance(from: thisLocation) < distance
    }

    public func isWithin(_ distance: CLLocationDistance, of coordinates: [CLLocationCoordinate2D]) -> Bool {
        for coordinate in coordinates {
            if isWithin(distance, of: coordinate) {
                return true
            }
        }

        return false
    }

}
