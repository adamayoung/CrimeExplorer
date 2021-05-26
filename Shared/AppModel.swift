import Combine
import Foundation
import MapKit
import SwiftUI

final class AppModel: ObservableObject {

    @Published private(set) var authorisationStatus: CLAuthorizationStatus = .notDetermined
    @Published private(set) var currentLocation: CLLocation?
    @Published var region: MKCoordinateRegion
    @Published var userTrackingMode: MapUserTrackingMode = .follow

    private var cancellables: Set<AnyCancellable> = []

    private let locationManager: LocationManager

    init(locationManager: LocationManager = LocationManager(), initialRegion: MKCoordinateRegion = .default) {
        self.locationManager = locationManager
        self.region = initialRegion

        // swiftlint:disable first_where
        locationManager.$currentLocation
            .filter { $0 != nil }
            .first()
            .sink(receiveValue: zoomToLocation)
            .store(in: &cancellables)
        // swiftlint:enable first_where

        locationManager.$currentLocation
            .assign(to: \.currentLocation, on: self)
            .store(in: &cancellables)
    }

    func requestLocationAuthorization() {
        locationManager.requestAuthorization()
    }

    func zoomToCurrentLocation() {
        zoomToLocation(currentLocation)
    }

}

extension AppModel {

    private func zoomToLocation(_ location: CLLocation?) {
        guard let location = location else {
            return
        }

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
