import Combine
import CrimeExplorerCore
import Foundation
import MapKit
import SwiftUI

final class AppModel: ObservableObject {

    @Published private(set) var currentLocation: CLLocation?
    @Published var region: MKCoordinateRegion
    @Published var userTrackingMode: MapUserTrackingMode = .follow
    @Published var crimes: [Crime] = []

    @Published private var allCrimes: [Crime] = []
    private let backgroundScheduler = DispatchQueue.global(qos: .userInitiated)
    private var cancellables: Set<AnyCancellable> = []
    private let locationService: LocationService
    private let crimeManager: CrimeManager

    init(locationService: LocationService = CLLocationService(), crimeManager: CrimeManager = UKCrimeManager(),
         initialRegion: MKCoordinateRegion = .default) {
        self.locationService = locationService
        self.crimeManager = crimeManager
        self.region = initialRegion

        setupBindings()
    }

    func updateRegionToCurrentLocation() {
        guard let currentLocation = currentLocation else {
            return
        }

        updateRegion(toLocation: currentLocation)
    }

}

extension AppModel {

    private func setupBindings() {
        locationService.locationPublisher()
            .compactMap { $0 }
            .removeDuplicates()
            .assign(to: \.currentLocation, on: self)
            .store(in: &cancellables)

        $currentLocation
            .compactMap { $0 }
            .first()
            .sink(receiveValue: updateRegion(toLocation:))
            .store(in: &cancellables)

        $region
            .debounce(for: .milliseconds(500), scheduler: backgroundScheduler)
            .removeDuplicates { $1.isWithin(distance: 804, of: $0) }
            .filter { $0.shouldAnnotationsBeVisible }
            .map { $0.center }
            .flatMap(self.crimeManager.crimesPublisher(atCoordinate:))
            .map { fetchedCrimes in
                let fetchedCrimes = Set(fetchedCrimes)
                let currentCrimes = Set(self.allCrimes)
                let crimes = currentCrimes.union(fetchedCrimes)
                return Array(crimes)
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.allCrimes, on: self)
            .store(in: &cancellables)

        Publishers.CombineLatest($region, $allCrimes)
            .throttle(for: .milliseconds(100), scheduler: backgroundScheduler, latest: true)
            .map { (region, crimes) -> [Crime] in
                guard region.shouldAnnotationsBeVisible else {
                    return []
                }

                return crimes
            }
            .map {
                $0.filter {
                    self.region.contains(coordinate: $0.location.coordinate)
                }
            }
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .assign(to: \.crimes, on: self)
            .store(in: &cancellables)
    }

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
