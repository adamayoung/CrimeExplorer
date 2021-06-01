import CoreLocation
import Foundation
import SwiftUI

public struct StreetCrimeSummary: Identifiable, Equatable, Hashable {

    public let id: Int
    public let name: String
    public let coordinate: CLLocationCoordinate2D
    public private(set) var crimes: [StreetCrimeSummary.Crime]

    public init(id: Int, name: String, coordinate: CLLocationCoordinate2D, crimes: [Crime]) {
        self.id = id
        self.name = name
        self.coordinate = coordinate
        self.crimes = crimes
    }

    mutating func append(crime: Crime) {
        self.crimes.append(crime)
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: StreetCrimeSummary, rhs: StreetCrimeSummary) -> Bool {
        lhs.id == rhs.id
    }

}

extension StreetCrimeSummary {

    public struct Crime: Identifiable, Equatable {

        public let id: String
        public let context: String?
        public let category: CrimeCategory
        public let date: Date

        public init(id: String, context: String? = nil, category: CrimeCategory, date: Date) {
            self.id = id
            self.context = context
            self.category = category
            self.date = date
        }

    }

}
