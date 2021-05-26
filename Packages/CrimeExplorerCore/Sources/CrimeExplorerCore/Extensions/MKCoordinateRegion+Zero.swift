import Foundation
import MapKit

public extension MKCoordinateRegion {

    static var `default`: MKCoordinateRegion {
        .uk
    }

    static var uk: MKCoordinateRegion {
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 54.4661645479556,
                longitude: -3.1076525162671667
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 13.0738,
                longitudeDelta: 11.4748
            )
        )
    }

    static var towerOfLondon: MKCoordinateRegion {
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 51.508530,
                longitude: -0.076132
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 0.1,
                longitudeDelta: 0.1
            )
        )
    }

}
