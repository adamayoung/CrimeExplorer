@testable import CrimeExplorerCore
import UKPoliceData
import XCTest

class CrimeCategoryUKPoliceDataTests: XCTestCase {

    func testInitWithUKPoliceDataCrimeCategoryReturnsCrimeCategory() {
        let crimeCategory = UKPoliceData.CrimeCategory(id: "all-crime", name: "All crime")
        let expectedResult = CrimeCategory.allCrime

        let result = CrimeCategory(category: crimeCategory)

        XCTAssertEqual(result, expectedResult)
    }

    func testInitWithInvalidUKPoliceDataCrimeCategoryReturnsDefaultCrimeCategory() {
        let crimeCategory = UKPoliceData.CrimeCategory(id: "some-crime", name: "Some crime")
        let expectedResult = CrimeCategory.default

        let result = CrimeCategory(category: crimeCategory)

        XCTAssertEqual(result, expectedResult)
    }

    func testInitWithIDReturnsCrimeCategory() {
        let id = "all-crime"
        let expectedResult = CrimeCategory.allCrime

        let result = CrimeCategory(id: id)

        XCTAssertEqual(result, expectedResult)
    }

    func testInitWithInvalidIDReturnsDefaultCrimeCategory() {
        let id = "some-crime"
        let expectedResult = CrimeCategory.default

        let result = CrimeCategory(id: id)

        XCTAssertEqual(result, expectedResult)
    }

}
