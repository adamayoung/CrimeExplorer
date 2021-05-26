import Combine
import Foundation
import MapKit

public protocol LocationService {

    func locationPublisher() -> AnyPublisher<CLLocation, Never>

}

public final class CLLocationService: NSObject, LocationService {

    private let locationManager = CLLocationManager()

    private var locationSubject = PassthroughSubject<CLLocation, Never>()

    public override init() {
        super.init()

        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    public func locationPublisher() -> AnyPublisher<CLLocation, Never> {
        let deferred: Deferred<AnyPublisher<CLLocation, Never>> = Deferred { [weak self] in
            guard let self = self else {
                return Empty<CLLocation, Never>().eraseToAnyPublisher()
            }

            self.locationManager.requestWhenInUseAuthorization()
            return self.locationSubject.eraseToAnyPublisher()
        }

        return deferred.eraseToAnyPublisher()
    }

}

extension CLLocationService: CLLocationManagerDelegate {

    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()

        default:
            break
        }
    }

    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.forEach {
            locationSubject.send($0)
        }
    }

}
