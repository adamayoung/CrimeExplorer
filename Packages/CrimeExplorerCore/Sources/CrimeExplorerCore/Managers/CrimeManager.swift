import Combine
import CoreLocation
import Foundation
import UKPoliceData

public protocol CrimeManager {

    func streetCrimeSummariesPublisher(
        atCoordinate coordinate: CLLocationCoordinate2D) -> AnyPublisher<[StreetCrimeSummary], Never>

}

public final class UKCrimeManager: CrimeManager {

    private let crimeService: CrimeService

    public init(crimeService: CrimeService = UKPoliceDataAPI.shared.crimes) {
        self.crimeService = crimeService
    }

    public func streetCrimeSummariesPublisher(
        atCoordinate coordinate: CLLocationCoordinate2D) -> AnyPublisher<[StreetCrimeSummary], Never> {
        let coordinate = Coordinate(coordinate: coordinate)
        return crimeService.streetLevelCrimesPublisher(atCoordinate: coordinate)
            .retry(5)
            .map(StreetCrimeSummary.create)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

}
