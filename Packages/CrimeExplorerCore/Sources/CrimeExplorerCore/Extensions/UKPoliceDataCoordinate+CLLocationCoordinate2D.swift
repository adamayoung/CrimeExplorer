import CoreLocation
import Foundation
import UKPoliceData

extension Coordinate {

    init(coordinate: CLLocationCoordinate2D) {
        self.init(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }

}

extension CLLocationCoordinate2D {

    init(coordinate: Coordinate) {
        self.init(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }

}
