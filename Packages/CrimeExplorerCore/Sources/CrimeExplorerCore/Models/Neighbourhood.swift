import CoreLocation
import Foundation

public struct Neighbourhood: Identifiable, Equatable, Hashable {

    public let id: String
    public let name: String
    public let center: CLLocationCoordinate2D

    public init(id: String, name: String, center: CLLocationCoordinate2D) {
        self.id = id
        self.name = name
        self.center = center
    }

    public static func == (lhs: Neighbourhood, rhs: Neighbourhood) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(center.latitude)
        hasher.combine(center.longitude)
    }

}
