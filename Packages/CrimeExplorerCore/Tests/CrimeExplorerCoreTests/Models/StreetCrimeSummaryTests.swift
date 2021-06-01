import CoreLocation
@testable import CrimeExplorerCore
import XCTest

class StreetCrimeSummaryTests: XCTestCase {

    func testAppendCrimeAddsCrimeToCrimes() {
        var streetCrimeSummary = StreetCrimeSummary(
            id: 1,
            name: "On or near Fake Street",
            coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0),
            crimes: []
        )

        let crime = StreetCrimeSummary.Crime(
            id: "2",
            context: "Some guy stole a bike",
            category: .bicycleTheft,
            date: Date()
        )

        streetCrimeSummary.append(crime: crime)

        XCTAssertEqual(streetCrimeSummary.crimes.count, 1)
        XCTAssertEqual(streetCrimeSummary.crimes[0], crime)
    }

    func testHashWhenIDsMatchReturnsTrue() {
        let streetCrimeSummary1 = StreetCrimeSummary(
            id: 1,
            name: "On or near Fake Street",
            coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0),
            crimes: []
        )

        let streetCrimeSummary2 = StreetCrimeSummary(
            id: 1,
            name: "On or near Madeup Street",
            coordinate: CLLocationCoordinate2D(latitude: 1, longitude: 1),
            crimes: []
        )

        XCTAssertEqual(streetCrimeSummary1.hashValue, streetCrimeSummary2.hashValue)
    }

    func testHashWhenIDsDoNotMatchReturnsFalse() {
        let streetCrimeSummary1 = StreetCrimeSummary(
            id: 1,
            name: "On or near Fake Street",
            coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0),
            crimes: []
        )

        let streetCrimeSummary2 = StreetCrimeSummary(
            id: 2,
            name: "On or near Fake Street",
            coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0),
            crimes: []
        )

        XCTAssertNotEqual(streetCrimeSummary1.hashValue, streetCrimeSummary2.hashValue)
    }

    func testEqualsWhenIDsMatchReturnsTrue() {
        let streetCrimeSummary1 = StreetCrimeSummary(
            id: 1,
            name: "On or near Fake Street",
            coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0),
            crimes: []
        )

        let streetCrimeSummary2 = StreetCrimeSummary(
            id: 1,
            name: "On or near Madeup Street",
            coordinate: CLLocationCoordinate2D(latitude: 1, longitude: 1),
            crimes: []
        )

        XCTAssertEqual(streetCrimeSummary1, streetCrimeSummary2)
    }

    func testEqualsWhenIDsDoNotMatchReturnsFalse() {
        let streetCrimeSummary1 = StreetCrimeSummary(
            id: 1,
            name: "On or near Fake Street",
            coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0),
            crimes: []
        )

        let streetCrimeSummary2 = StreetCrimeSummary(
            id: 2,
            name: "On or near Fake Street",
            coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0),
            crimes: []
        )

        XCTAssertNotEqual(streetCrimeSummary1, streetCrimeSummary2)
    }

}
