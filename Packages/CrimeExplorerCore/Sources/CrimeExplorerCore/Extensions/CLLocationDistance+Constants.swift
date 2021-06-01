import CoreLocation
import Foundation

extension CLLocationDistance {

    public static var halfMile: CLLocationDistance {
        Measurement(value: 0.5, unit: UnitLength.miles)
            .converted(to: .meters)
            .value
    }

}
