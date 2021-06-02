import CoreLocation
import Foundation
import UKPoliceData

extension Neighbourhood {

    init(neighbourhood: UKPoliceData.Neighbourhood) {
        let center = CLLocationCoordinate2D(coordinate: neighbourhood.centre)
        self.init(id: neighbourhood.id, name: neighbourhood.name, center: center)
    }

}
