@testable import CrimeExplorerCore
import XCTest

class CrimeCategoryTests: XCTestCase {

    func testDefaultReturnsOtherCrime() {
        let expectedResult = CrimeCategory.otherCrime

        let result = CrimeCategory.default

        XCTAssertEqual(result, expectedResult)
    }

}
