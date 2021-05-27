import CoreLocation
import Foundation

public struct Crime: Identifiable, Equatable, Hashable {

    public let id: String
    public let context: String?
    public let category: CrimeCategory
    public let street: Street
    public let location: CLLocation

    public init(id: String, context: String? = nil, category: CrimeCategory, street: Street, location: CLLocation) {
        self.id = id
        self.context = context
        self.category = category
        self.street = street
        self.location = location
    }

    public static func == (lhs: Crime, rhs: Crime) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
           hasher.combine(id)
       }

}
