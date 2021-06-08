import Combine
import CrimeExplorerCore
import Foundation
import MapKit
import SwiftUI

final class AppModel: ObservableObject {

    private static let dataAvailabilityRegion = MKCoordinateRegion.uk

    @Published private(set) var currentLocation: CLLocation?
    @Published var region: MKCoordinateRegion
    @Published var userTrackingMode: MapUserTrackingMode = .follow
    @Published private(set) var streetCrimeSummaries: [StreetCrimeSummary] = []
    @Published var selectedStreetCrimeSummary: StreetCrimeSummary?
    @Published var currentNeighbourhood: Neighbourhood?

    private let backgroundScheduler = DispatchQueue.global(qos: .userInitiated)
    private let locationService: LocationService
    private let crimeManager: CrimeManager
    private let neighbourhoodManager: NeighbourhoodManager
    @Published private var allStreetCrimeSummaries: [StreetCrimeSummary] = []
    private var requestedLocationCoordinates: [CLLocationCoordinate2D] = []
    private var cancellables: Set<AnyCancellable> = []

    init(locationService: LocationService = CLLocationService(), crimeManager: CrimeManager = UKCrimeManager(),
         neighbourhoodManager: NeighbourhoodManager = UKNeighbourhoodManager(),
         initialRegion: MKCoordinateRegion = .default) {
        self.locationService = locationService
        self.crimeManager = crimeManager
        self.neighbourhoodManager = neighbourhoodManager
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

        setupRegionBindings()

        Publishers.CombineLatest($region, $allStreetCrimeSummaries)
            .throttle(for: .milliseconds(100), scheduler: backgroundScheduler, latest: true)
            .map { (region, summaries) in
                region.shouldAnnotationsBeVisible ? summaries : []
            }
            .map {
                $0.filter { self.region.contains(coordinate: $0.coordinate) }
            }
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .assign(to: \.streetCrimeSummaries, on: self)
            .store(in: &cancellables)
    }

    private func setupRegionBindings() {
        $region
            .debounce(for: .milliseconds(500), scheduler: backgroundScheduler)
            .filter { $0.shouldAnnotationsBeVisible }
            .map { $0.center }
            .filter { Self.dataAvailabilityRegion.contains(coordinate: $0) }
            .removeDuplicates {
                $1.isWithin(.halfMile, of: self.requestedLocationCoordinates)
            }
            .handleEvents(receiveOutput: { self.requestedLocationCoordinates.append($0) })
            .flatMap(self.crimeManager.streetCrimeSummariesPublisher(atCoordinate:))
            .map { fetchedSummaries in
                let fetchedSummaries = Set(fetchedSummaries)
                let currentSummaries = Set(self.allStreetCrimeSummaries)
                let summaries = currentSummaries.union(fetchedSummaries)
                return Array(summaries)
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.allStreetCrimeSummaries, on: self)
            .store(in: &cancellables)

        $region
            .throttle(for: .seconds(2), scheduler: backgroundScheduler, latest: true)
            .map { $0.center }
            .map(self.neighbourhoodManager.neighbourhoodPublisher(atCoordinate:))
            .switchToLatest()
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .assign(to: \.currentNeighbourhood, on: self)
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
