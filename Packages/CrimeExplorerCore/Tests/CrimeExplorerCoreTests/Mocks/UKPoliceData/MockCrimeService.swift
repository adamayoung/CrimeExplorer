import Combine
import Foundation
import UKPoliceData

final class MockCrimeService: CrimeService {

    var streetLevelCrimesPublisherResult: Result<[Crime], PoliceDataError>?
    private(set) var lastStreetLevelCrimesPublisherCoordinate: Coordinate?

    func fetchCategories(date: Date, completion: @escaping (Result<[CrimeCategory], PoliceDataError>) -> Void) {
        completion(.success([]))
    }

    func categoriesPublisher(date: Date) -> AnyPublisher<[CrimeCategory], PoliceDataError> {
        Empty<[CrimeCategory], PoliceDataError>()
            .eraseToAnyPublisher()
    }

    func streetLevelCrimesPublisher(atCoordinate coordinate: Coordinate,
                                    date: Date?) -> AnyPublisher<[Crime], PoliceDataError> {
        lastStreetLevelCrimesPublisherCoordinate = coordinate

        guard let result = streetLevelCrimesPublisherResult else {
            return Empty<[Crime], PoliceDataError>()
                .eraseToAnyPublisher()
        }

        return result.publisher
            .eraseToAnyPublisher()
    }

}
