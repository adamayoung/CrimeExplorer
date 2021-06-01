@testable import CrimeExplorerCore
import MapKit
import XCTest

class MKCoordinateRegionContainsCoordinateTests: XCTestCase {

    var region: MKCoordinateRegion!

    override func setUp() {
        super.setUp()
        region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 54.5,
                longitude: -3.0
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 2.5,
                longitudeDelta: 2.5
            )
        )
    }

    override func tearDown() {
        region = nil
        super.tearDown()
    }

    func testContainsCoordinateWhenCoordinateIsInsideRegionReturnsTrue() {
        let coordinate = region.center

        let result = region.contains(coordinate: coordinate)

        XCTAssertTrue(result)
    }

    func testContainsCoordinateWhenCoordinateNorthOfRegionReturnsFalse() {
        let coordinate = CLLocationCoordinate2D(
            latitude: region.center.latitude + region.span.latitudeDelta,
            longitude: region.center.longitude
        )

        let result = region.contains(coordinate: coordinate)

        XCTAssertFalse(result)
    }

    func testContainsCoordinateWhenCoordinateNorthEastOfRegionReturnsFalse() {
        let coordinate = CLLocationCoordinate2D(
            latitude: region.center.latitude + region.span.latitudeDelta,
            longitude: region.center.longitude + region.span.longitudeDelta
        )

        let result = region.contains(coordinate: coordinate)

        XCTAssertFalse(result)
    }

    func testContainsCoordinateWhenCoordinateEastOfRegionReturnsFalse() {
        let coordinate = CLLocationCoordinate2D(
            latitude: region.center.latitude,
            longitude: region.center.longitude + region.span.longitudeDelta
        )

        let result = region.contains(coordinate: coordinate)

        XCTAssertFalse(result)
    }

    func testContainsCoordinateWhenCoordinateSouthEastOfRegionReturnsFalse() {
        let coordinate = CLLocationCoordinate2D(
            latitude: region.center.latitude - region.span.latitudeDelta,
            longitude: region.center.longitude + region.span.longitudeDelta
        )

        let result = region.contains(coordinate: coordinate)

        XCTAssertFalse(result)
    }

    func testContainsCoordinateWhenCoordinateSouthOfRegionReturnsFalse() {
        let coordinate = CLLocationCoordinate2D(
            latitude: region.center.latitude - region.span.latitudeDelta,
            longitude: region.center.longitude
        )

        let result = region.contains(coordinate: coordinate)

        XCTAssertFalse(result)
    }

    func testContainsCoordinateWhenCoordinateSouthWestOfRegionReturnsFalse() {
        let coordinate = CLLocationCoordinate2D(
            latitude: region.center.latitude - region.span.latitudeDelta,
            longitude: region.center.longitude - region.span.longitudeDelta
        )

        let result = region.contains(coordinate: coordinate)

        XCTAssertFalse(result)
    }

    func testContainsCoordinateWhenCoordinateWestOfRegionReturnsFalse() {
        let coordinate = CLLocationCoordinate2D(
            latitude: region.center.latitude - region.span.latitudeDelta,
            longitude: region.center.longitude
        )

        let result = region.contains(coordinate: coordinate)

        XCTAssertFalse(result)
    }

    func testContainsCoordinateWhenCoordinateNorthWestOfRegionReturnsFalse() {
        let coordinate = CLLocationCoordinate2D(
            latitude: region.center.latitude + region.span.latitudeDelta,
            longitude: region.center.longitude - region.span.longitudeDelta
        )

        let result = region.contains(coordinate: coordinate)

        XCTAssertFalse(result)
    }

}
