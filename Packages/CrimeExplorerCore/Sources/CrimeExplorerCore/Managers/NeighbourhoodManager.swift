import Combine
import CoreLocation
import Foundation
import UKPoliceData

public protocol NeighbourhoodManager {

    func neighbourhoodPublisher(atCoordinate coordinate: CLLocationCoordinate2D) -> AnyPublisher<Neighbourhood?, Never>

}

public final class UKNeighbourhoodManager: NeighbourhoodManager {

    private let neighbourhoodService: NeighbourhoodService
    private let neighbourhoodCache = Cache<String, Neighbourhood>()

    public init(neighbourhoodService: NeighbourhoodService = UKPoliceDataAPI.shared.neighbourhoods) {
        self.neighbourhoodService = neighbourhoodService
    }

    public func neighbourhoodPublisher(
        atCoordinate coordinate: CLLocationCoordinate2D) -> AnyPublisher<Neighbourhood?, Never> {
        neighbourhoodService.neighbourhoodPublisher(atCoordinate: coordinate)
            .flatMap { policeForceNeighbourhood -> AnyPublisher<Neighbourhood?, PoliceDataError> in
                if let cached = self.neighbourhoodCache[policeForceNeighbourhood.id] {
                    return Just(cached)
                        .setFailureType(to: PoliceDataError.self)
                        .eraseToAnyPublisher()
                }

                return self.neighbourhoodService
                    .detailsPublisher(forNeighbourhood: policeForceNeighbourhood.neighbourhood,
                                      inPoliceForce: policeForceNeighbourhood.force)
                    .map(Neighbourhood.init)
                    .handleEvents(receiveOutput: {
                        self.neighbourhoodCache[policeForceNeighbourhood.id] = $0
                    })
                    .eraseToAnyPublisher()
            }
            .retry(5)
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }

}

extension NeighbourhoodService {

    func neighbourhoodPublisher(
        atCoordinate coordinate: CLLocationCoordinate2D) -> AnyPublisher<PoliceForceNeighbourhood, PoliceDataError> {
        let coordinate = Coordinate(coordinate: coordinate)
        return neighbourhoodPublisher(atCoordinate: coordinate)
    }

}

extension UKPoliceData.PoliceForceNeighbourhood: Identifiable {

    public var id: String {
        "\(neighbourhood)-\(force)"
    }

}
