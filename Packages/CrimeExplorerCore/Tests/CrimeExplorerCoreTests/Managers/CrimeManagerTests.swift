import Combine
import CoreLocation
@testable import CrimeExplorerCore
import UKPoliceData
import XCTest

class CrimeManagerTests: XCTestCase {

    var crimeService: MockCrimeService!
    var manager: UKCrimeManager!
    var cancellables: Set<AnyCancellable> = []

    let crimes = [
        UKPoliceData.Crime(
            id: 1,
            crimeID: "c1",
            context: "Crime 1 context",
            categoryID: "all-crime",
            location: Location(
                street: Location.Street(
                    id: 2,
                    name: "Fake Street"
                ),
                coordinate: Coordinate(
                    latitude: 53.111,
                    longitude: -0.733
                )
            ),
            locationType: .force,
            date: Date()
        ),
        UKPoliceData.Crime(
            id: 2,
            crimeID: "c2",
            context: "Crime 2 context",
            categoryID: "criminal-damage-arson",
            location: Location(
                street: Location.Street(
                    id: 4,
                    name: "Madeup Street"
                ),
                coordinate: Coordinate(
                    latitude: 51.444,
                    longitude: -0.9111
                )
            ),
            locationType: .btp,
            date: Date()
        ),
        UKPoliceData.Crime(
            id: 3,
            crimeID: "c3",
            context: "Crime 3 context",
            categoryID: "violent-crime",
            location: Location(
                street: Location.Street(
                    id: 2,
                    name: "Fake Street"
                ),
                coordinate: Coordinate(
                    latitude: 53.111,
                    longitude: -0.733
                )
            ),
            locationType: .force,
            date: Date()
        )
    ]

    override func setUp() {
        super.setUp()
        crimeService = MockCrimeService()
        manager = UKCrimeManager(crimeService: crimeService)
    }

    override func tearDown() {
        crimeService = nil
        manager = nil
        super.tearDown()
    }

    func testStreetCrimeSummariesPublisherReturnsStreetCrimeSummaries() throws {
        let coordinate = CLLocationCoordinate2D(latitude: 53.1, longitude: -0.7)
        crimeService.streetLevelCrimesPublisherResult = .success(crimes)

        let expectedResult = [
            StreetCrimeSummary(
                id: 2,
                name: "Fake Street",
                coordinate: CLLocationCoordinate2D(latitude: 53.111, longitude: -0.733),
                crimes: [
                    StreetCrimeSummary.Crime(id: "c1", context: "Crime 1 context", category: .allCrime,
                                             date: crimes[0].date),
                    StreetCrimeSummary.Crime(id: "c3", context: "Crime 3 context", category: .violentCrime,
                                             date: crimes[2].date)
                ]
            ),
            StreetCrimeSummary(
                id: 4,
                name: "Madeup Street",
                coordinate: CLLocationCoordinate2D(latitude: 51.444, longitude: -0.9111),
                crimes: [
                    StreetCrimeSummary.Crime(id: "c2", context: "Crime 2 context", category: .criminalDamageArson,
                                             date: crimes[1].date)
                ]
            )
        ]

        let result = try waitFor(publisher: manager.streetCrimeSummariesPublisher(atCoordinate: coordinate),
                             storeIn: &cancellables)

        var resultDict = [Int: StreetCrimeSummary]()
        result?.forEach { summary in
            resultDict[summary.id] = summary
        }

        XCTAssertEqual(
            crimeService.lastStreetLevelCrimesPublisherCoordinate,
            Coordinate(latitude: coordinate.latitude, longitude: coordinate.longitude)
        )
        XCTAssertEqual(result?.count, expectedResult.count)
        XCTAssertEqual(resultDict[expectedResult[0].id]?.id, expectedResult[0].id)
        XCTAssertEqual(resultDict[expectedResult[0].id]?.name, expectedResult[0].name)
        XCTAssertEqual(resultDict[expectedResult[0].id]?.crimes, expectedResult[0].crimes)
        XCTAssertEqual(resultDict[expectedResult[1].id]?.id, expectedResult[1].id)
        XCTAssertEqual(resultDict[expectedResult[1].id]?.name, expectedResult[1].name)
        XCTAssertEqual(resultDict[expectedResult[1].id]?.crimes, expectedResult[1].crimes)
    }

    func testStreetCrimeSummariesPublisherWhenErrorsReturnsEmptyStreetCrimeSummaries() throws {
        let coordinate = CLLocationCoordinate2D(latitude: 53.1, longitude: -0.7)
        let error = PoliceDataError.unknown
        crimeService.streetLevelCrimesPublisherResult = .failure(error)

        let result = try waitFor(publisher: manager.streetCrimeSummariesPublisher(atCoordinate: coordinate),
                                 storeIn: &cancellables)

        XCTAssertEqual(result?.isEmpty, true)
    }

}
