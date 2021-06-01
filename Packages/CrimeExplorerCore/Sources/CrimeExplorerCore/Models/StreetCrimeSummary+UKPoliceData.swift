import CoreLocation
import Foundation
import UKPoliceData

extension StreetCrimeSummary {

    static func create(crimes: [UKPoliceData.Crime]) -> [StreetCrimeSummary] {
        var summariesMap = [StreetCrimeSummary.ID: StreetCrimeSummary]()

        crimes.forEach { crime in
            let streetID = crime.location.street.id
            var summary = summariesMap[streetID] ?? StreetCrimeSummary(fromCrime: crime)
            let crime = StreetCrimeSummary.Crime(crime: crime)
            summary.append(crime: crime)
            summariesMap[streetID] = summary
        }

        return Array(summariesMap.values)
    }

    private init(fromCrime crime: UKPoliceData.Crime) {
        let coordinate = CLLocationCoordinate2D(coordinate: crime.location.coordinate)
        self.init(id: crime.location.street.id, name: crime.location.street.name, coordinate: coordinate, crimes: [])
    }

}

extension StreetCrimeSummary.Crime {

    init(crime: UKPoliceData.Crime) {
        let category = CrimeCategory(id: crime.categoryID)
        self.init(id: crime.crimeID, context: crime.context, category: category, date: crime.date)
    }

}
