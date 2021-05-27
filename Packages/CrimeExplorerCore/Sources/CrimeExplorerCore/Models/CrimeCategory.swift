import Foundation
import SwiftUI

public enum CrimeCategory: String, CaseIterable, CustomStringConvertible {

    static let `default` = CrimeCategory.otherCrime

    case allCrime = "all-crime"
    case antiSocialBehaviour = "anti-social-behaviour"
    case bicycleTheft = "bicycle-theft"
    case burglary = "burglary"
    case criminalDamageArson = "criminal-damage-arson"
    case drugs = "drugs"
    case otherTheft = "other-theft"
    case possessionOfWeapons = "possession-of-weapons"
    case publicOrder = "public-order"
    case robbery = "robbery"
    case shoplifting = "shoplifting"
    case theftFromThePerson = "theft-from-the-person"
    case vehicleCrime = "vehicle-crime"
    case violentCrime = "violent-crime"
    case otherCrime = "other-crime"

    public var description: String {
        switch self {
        case .allCrime:
            return "All crime"

        case .antiSocialBehaviour:
            return "Anti-social behaviour"

        case .bicycleTheft:
            return "Bicycle theft"

        case .burglary:
            return "Burglary"

        case .criminalDamageArson:
            return "Criminal damage and arson"

        case .drugs:
            return "Drugs"

        case .otherTheft:
            return "Other theft"

        case .possessionOfWeapons:
            return "Possession of weapons"

        case .publicOrder:
            return "Public order"

        case .robbery:
            return "Robbery"

        case .shoplifting:
            return "Shoplifting"

        case .theftFromThePerson:
            return "Theft from the person"

        case .vehicleCrime:
            return "Vehicle crime"

        case .violentCrime:
            return "Violence or sexual offence"

        case .otherCrime:
            return "Other crime"
        }
    }

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
            return Color(#colorLiteral(red: 0.9514275193, green: 0.260519743, blue: 0.2063847184, alpha: 1))

        case .antiSocialBehaviour:
            return Color(#colorLiteral(red: 0.9089515805, green: 0.115500547, blue: 0.3824329972, alpha: 1))

        case .bicycleTheft:
            return Color(#colorLiteral(red: 0.6055114865, green: 0.1469495893, blue: 0.6858384013, alpha: 1))

        case .burglary:
            return Color(#colorLiteral(red: 0.2393574417, green: 0.3042640984, blue: 0.6945958734, alpha: 1))

        case .criminalDamageArson:
            return Color(#colorLiteral(red: 0.1312086582, green: 0.5832560658, blue: 0.949138701, alpha: 1))

        case .drugs:
            return Color(#colorLiteral(red: 0.009701920673, green: 0.6566796303, blue: 0.9542275071, alpha: 1))

        case .otherTheft:
            return Color(#colorLiteral(red: 0, green: 0.7312861085, blue: 0.828542769, alpha: 1))

        case .possessionOfWeapons:
            return Color(#colorLiteral(red: 0, green: 0.5858674645, blue: 0.5291246772, alpha: 1))

        case .publicOrder:
            return Color(#colorLiteral(red: 0.2939592004, green: 0.6816617846, blue: 0.3081095219, alpha: 1))

        case .robbery:
            return Color(#colorLiteral(red: 0.5405394435, green: 0.7620247006, blue: 0.2870618105, alpha: 1))

        case .shoplifting:
            return Color(#colorLiteral(red: 0.8000716567, green: 0.8605659604, blue: 0.218424499, alpha: 1))

        case .theftFromThePerson:
            return Color(#colorLiteral(red: 0.9969183803, green: 0.9189836383, blue: 0.2245070338, alpha: 1))

        case .vehicleCrime:
            return Color(#colorLiteral(red: 0.9980309606, green: 0.7505165339, blue: 0.01617708243, alpha: 1))

        case .violentCrime:
            return Color(#colorLiteral(red: 0.9961102605, green: 0.591531992, blue: 0.002779310104, alpha: 1))

        case .otherCrime:
            return Color(#colorLiteral(red: 0.9948402047, green: 0.3385801315, blue: 0.1256340742, alpha: 1))
        }
    }

}
