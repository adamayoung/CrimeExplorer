import Foundation
import MapKit

extension MKCoordinateRegion {

    public func contains(coordinate: CLLocationCoordinate2D, margin: Double = 0.01) -> Bool {
        let northWestCoordinate = self.northWestCoordinate
        let southEastRightCoordinate = self.southEastRightCoordinate

        return coordinate.latitude >= northWestCoordinate.latitude - margin
            && coordinate.longitude >= northWestCoordinate.longitude - margin
            && coordinate.latitude <= southEastRightCoordinate.latitude + margin
            && coordinate.longitude <= southEastRightCoordinate.longitude + margin
    }

}

extension MKCoordinateRegion {

    private var northWestCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: center.latitude - (span.latitudeDelta / 2),
            longitude: center.longitude - (span.longitudeDelta / 2)
        )
    }

    private var southEastRightCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: center.latitude + (span.latitudeDelta / 2.0),
            longitude: center.longitude + (span.longitudeDelta / 2.0)
        )
    }

}
