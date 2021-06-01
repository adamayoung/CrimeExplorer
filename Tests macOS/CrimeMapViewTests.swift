import XCTest

class CrimeMapViewTests: UITestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testMapAppears() throws {
        let crimeMap = app.maps.firstMatch
        XCTAssertTrue(crimeMap.exists)
    }

}
