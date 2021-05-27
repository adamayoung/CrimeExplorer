import CoreLocation
import Foundation
import UKPoliceData

extension Crime {

    init(crime: UKPoliceData.Crime) {
        let category = CrimeCategory(id: crime.categoryID)
        let street = Street(street: crime.location.street)
        let location = CLLocation(coordinate: crime.location.coordinate)

        self.init(id: crime.crimeID, context: crime.context, category: category, street: street,
                  location: location)
    }

}
