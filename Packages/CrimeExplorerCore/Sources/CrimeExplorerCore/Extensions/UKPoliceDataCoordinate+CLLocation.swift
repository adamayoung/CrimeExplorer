import CoreLocation
import Foundation
import UKPoliceData

extension Coordinate {

    init(coordinate: CLLocationCoordinate2D) {
        self.init(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }

}

extension CLLocation {

    convenience init(coordinate: Coordinate) {
        self.init(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }

}
