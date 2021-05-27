import Foundation
import UKPoliceData

extension Street {

    init(street: Location.Street) {
        self.init(id: street.id, name: street.name)
    }

}
