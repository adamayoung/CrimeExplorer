import CoreLocation
import Foundation

extension StreetCrimeSummary {

    public static var mocks: [StreetCrimeSummary] {
        var summaries = [StreetCrimeSummary]()

        let coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        let crime1 = Crime(id: "crime-multi-1", category: .allCrime, date: Date())
        let crime2 = Crime(id: "crime-multi-2", category: .allCrime, date: Date())
        let multiSummary = StreetCrimeSummary(id: -1, name: "Street Multi", coordinate: coordinate,
                                              crimes: [crime1, crime2])
        summaries.append(multiSummary)

        for (index, category) in CrimeCategory.allCases.enumerated() {
            let crime = Crime(id: "crime-\(index)", category: category, date: Date())
            summaries.append(StreetCrimeSummary(id: index, name: "Street \(index)", coordinate: coordinate,
                                                crimes: [crime]))
        }

        return summaries
    }

}
