import CoreLocation
@testable import CrimeExplorerCore
import XCTest

class CLLocationDistanceConstantsTests: XCTestCase {

    func testHalfMileReturnsDistance() {
        let expectedResult: CLLocationDistance = 804.672

        let result = CLLocationDistance.halfMile

        XCTAssertEqual(result, expectedResult)
    }

}
