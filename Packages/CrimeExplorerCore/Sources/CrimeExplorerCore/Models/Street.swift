import Foundation

public struct Street: Identifiable, Equatable, Hashable {

    public let id: Int
    public let name: String

    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }

}