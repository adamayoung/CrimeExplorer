import CoreLocation
@testable import CrimeExplorerCore
import XCTest

class CLLocationCoordinate2DWithInDistanceTests: XCTestCase {

    func testIsWithInWhenCoordinateIsOverOneHundredMetresAwayReturnsFalse() {
        let coordinate1 = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        let coordinate2 = CLLocationCoordinate2D(latitude: 53.10101, longitude: -0.73)
        let distance: CLLocationDistance = 100

        let result = coordinate1.isWithin(distance, of: coordinate2)

        XCTAssertFalse(result)
    }

    func testIsWithInWhenCoordinateIsLessThanTwoHundredMetresAwayReturnsTrue() {
        let coordinate1 = CLLocationCoordinate2D(latitude: 53.1, longitude: 0.2)
        let coordinate2 = CLLocationCoordinate2D(latitude: 53.101, longitude: 0.2)
        let distance: CLLocationDistance = 200

        let result = coordinate1.isWithin(distance, of: coordinate2)

        XCTAssertTrue(result)
    }

    func testIsWithWhenCordinatesAreOverOneHundredMetresAwayReturnsFalse() {
        let coordinate1 = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        let coordinates = [
            CLLocationCoordinate2D(latitude: 5, longitude: -0.73),
            CLLocationCoordinate2D(latitude: 10, longitude: -0.73),
            CLLocationCoordinate2D(latitude: 23, longitude: -0.73)
        ]
        let distance: CLLocationDistance = 100

        let result = coordinate1.isWithin(distance, of: coordinates)

        XCTAssertFalse(result)
    }

    func testIsWithWhenCordinatesAreLessThanTwoHundredMetresAwayReturnsTrue() {
        let coordinate1 = CLLocationCoordinate2D(latitude: 53.1, longitude: 0.2)
        let coordinates = [
            CLLocationCoordinate2D(latitude: 53.1005, longitude: 0.200001),
            CLLocationCoordinate2D(latitude: 53.101, longitude: 0.200002),
            CLLocationCoordinate2D(latitude: 53.1003, longitude: 0.200003)
        ]
        let distance: CLLocationDistance = 200

        let result = coordinate1.isWithin(distance, of: coordinates)

        XCTAssertTrue(result)
    }

}
