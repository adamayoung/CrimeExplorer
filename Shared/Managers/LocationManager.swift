import Combine
import Foundation
import MapKit

final class LocationManager: NSObject, ObservableObject {

    @Published fileprivate(set) var authorisationStatus: CLAuthorizationStatus = .notDetermined
    @Published fileprivate(set) var currentLocation: CLLocation?

    private let locationManager: CLLocationManager

    init(clLocationManager: CLLocationManager = CLLocationManager()) {
        self.locationManager = clLocationManager

        super.init()

        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }

}

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorisationStatus = status

        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            self.locationManager.startUpdatingLocation()

        default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
    }

}
