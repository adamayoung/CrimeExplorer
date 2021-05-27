import Combine
import CoreLocation
import Foundation
import UKPoliceData

public protocol CrimeManager {

    func crimesPublisher(atCoordinate coordinate: CLLocationCoordinate2D) -> AnyPublisher<[Crime], Never>

}

public final class UKCrimeManager: CrimeManager {

    private let crimeService: CrimeService

    public init(crimeService: CrimeService = UKPoliceDataAPI.shared.crimes) {
        self.crimeService = crimeService
    }

    public func crimesPublisher(atCoordinate coordinate: CLLocationCoordinate2D) -> AnyPublisher<[Crime], Never> {
        let coordinate = Coordinate(coordinate: coordinate)
        return crimeService.streetLevelCrimesPublisher(atCoordinate: coordinate)
            .retry(5)
            .map { crimes in
                crimes.map(Crime.init)
            }
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

}
