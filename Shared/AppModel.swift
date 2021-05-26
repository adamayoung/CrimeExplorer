import Combine
import CrimeExplorerCore
import Foundation
import MapKit
import SwiftUI

final class AppModel: ObservableObject {

    @Published private(set) var currentLocation: CLLocation?
    @Published var region: MKCoordinateRegion
    @Published var userTrackingMode: MapUserTrackingMode = .follow

    private var cancellables: Set<AnyCancellable> = []

    private let locationService: LocationService

    init(locationService: LocationService = CLLocationService(), initialRegion: MKCoordinateRegion = .default) {
        self.locationService = locationService
        self.region = initialRegion

        locationService.locationPublisher()
            .compactMap { $0 }
            .assign(to: \.currentLocation, on: self)
            .store(in: &cancellables)

        $currentLocation
            .compactMap { $0 }
            .first()
            .sink(receiveValue: updateRegion(toLocation:))
            .store(in: &cancellables)
    }

    func updateRegionToCurrentLocation() {
        guard let currentLocation = currentLocation else {
            return
        }

        updateRegion(toLocation: currentLocation)
    }

}

extension AppModel {

    private func updateRegion(toLocation location: CLLocation) {
        region = MKCoordinateRegion(
            center: location.coordinate,
            span: MKCoordinateSpan(
                latitudeDelta: 0.01,
                longitudeDelta: 0.01
            )
        )
    }

}

extension AppModel {

    static var mock: AppModel {
        AppModel(initialRegion: .towerOfLondon)
    }

}
