import Combine
import CoreLocation
@testable import CrimeExplorerCore
import XCTest

class CLLocationServiceTests: XCTestCase {

    var service: CLLocationService!
    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        service = CLLocationService()
    }

    override func tearDown() {
        service = nil
        super.tearDown()
    }

    func testLocationPublisherPublishesLocation() throws {
        let expectedResult = CLLocation(latitude: 10, longitude: 20)

        let expectation = XCTestExpectation(description: "locationUpdate")
        service.locationPublisher().first()
            .sink { result in
                XCTAssertEqual(result, expectedResult)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        service.locationManager(CLLocationManager(), didUpdateLocations: [expectedResult])
        wait(for: [expectation], timeout: 1)
    }

}
