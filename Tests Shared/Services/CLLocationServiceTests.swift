import Combine
import CoreLocation
@testable import CrimeExplorer
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
        let publisher = service.locationPublisher().first().eraseToAnyPublisher()
        let expectedResult = CLLocation(latitude: 10, longitude: 20)

        service.locationManager(CLLocationManager(), didUpdateLocations: [expectedResult])

        let result = try waitFor(publisher: publisher, storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
    }

}
