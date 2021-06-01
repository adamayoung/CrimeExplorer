import Foundation
import SwiftUI

extension CrimeCategory {

    public var image: Image {
        switch self {
        case .allCrime:
            return Image(systemName: "shield.fill")

        case .antiSocialBehaviour:
            return Image(systemName: "bubble.left.and.bubble.right.fill")

        case .bicycleTheft:
            return Image(systemName: "bicycle")

        case .burglary:
            return Image(systemName: "house.fill")

        case .criminalDamageArson:
            return Image(systemName: "flame.fill")

        case .drugs:
            return Image(systemName: "pills.fill")

        case .otherTheft:
            return Image(systemName: "shippingbox.fill")

        case .possessionOfWeapons:
            return Image(systemName: "wrench.and.screwdriver.fill")

        case .publicOrder:
            return Image(systemName: "person.3.fill")

        case .robbery:
            return Image(systemName: "figure.walk")

        case .shoplifting:
            return Image(systemName: "building.2.fill")

        case .theftFromThePerson:
            return Image(systemName: "figure.stand.line.dotted.figure.stand")

        case .vehicleCrime:
            return Image(systemName: "car.fill")

        case .violentCrime:
            return Image(systemName: "figure.wave")

        case .otherCrime:
            return Image(systemName: "questionmark.circle.fill")
        }
    }

    public var backgroundColor: Color {
        switch self {
        case .allCrime:
            return Color("allCrime", bundle: .module)

        case .antiSocialBehaviour:
            return Color("antiSocialBehaviour", bundle: .module)

        case .bicycleTheft:
            return Color("bicycleTheft", bundle: .module)

        case .burglary:
            return Color("burglary", bundle: .module)

        case .criminalDamageArson:
            return Color("criminalDamageArson", bundle: .module)

        case .drugs:
            return Color("drugs", bundle: .module)

        case .otherTheft:
            return Color("otherTheft", bundle: .module)

        case .possessionOfWeapons:
            return Color("possessionOfWeapons", bundle: .module)

        case .publicOrder:
            return Color("publicOrder", bundle: .module)

        case .robbery:
            return Color("robbery", bundle: .module)

        case .shoplifting:
            return Color("shoplifting", bundle: .module)

        case .theftFromThePerson:
            return Color("theftFromThePerson", bundle: .module)

        case .vehicleCrime:
            return Color("vehicleCrime", bundle: .module)

        case .violentCrime:
            return Color("violentCrime", bundle: .module)

        case .otherCrime:
            return Color("otherCrime", bundle: .module)
        }
    }

}
