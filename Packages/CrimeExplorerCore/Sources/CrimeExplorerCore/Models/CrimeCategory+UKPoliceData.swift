import Foundation
import UKPoliceData

extension CrimeCategory {

    init(category: UKPoliceData.CrimeCategory) {
        self = CrimeCategory(rawValue: category.id) ?? .default
    }

    init(id: String) {
        self = CrimeCategory(rawValue: id) ?? .default
    }

}
