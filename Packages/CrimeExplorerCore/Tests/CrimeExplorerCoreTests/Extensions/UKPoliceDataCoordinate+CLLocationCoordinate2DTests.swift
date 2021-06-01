import CoreLocation
@testable import CrimeExplorerCore
import UKPoliceData
import XCTest

class UKPoliceDataCoordinateCLLocationCoordinate2DTests: XCTestCase {

    func testInitCoordinateWithCLLocationCoordinate2DReturnsCooridnate() {
        let locationCoordinate = CLLocationCoordinate2D(latitude: 53.111, longitude: -0.73)

        let result = Coordinate(coordinate: locationCoordinate)

        XCTAssertEqual(result.latitude, locationCoordinate.latitude)
        XCTAssertEqual(result.longitude, locationCoordinate.longitude)
    }

    func testInitCLLocationCoordinate2DWithCoordinate2DReturnsCLLocationCoordinate2D() {
        let coordinate = Coordinate(latitude: 53.111, longitude: -0.73)

        let result = CLLocationCoordinate2D(coordinate: coordinate)

        XCTAssertEqual(result.latitude, coordinate.latitude)
        XCTAssertEqual(result.longitude, coordinate.longitude)
    }

}
