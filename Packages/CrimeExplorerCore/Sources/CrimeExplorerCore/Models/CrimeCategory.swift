import Foundation
import SwiftUI

public enum CrimeCategory: String, CaseIterable {

    static let `default`: CrimeCategory = .otherCrime

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

    public var name: String {
        switch self {
        case .allCrime:
            return NSLocalizedString("CRIME_CATEGORY_ALL_CRIME", bundle: .module,
                                     comment: "All crime crime category label")

        case .antiSocialBehaviour:
            return NSLocalizedString("CRIME_CATEGORY_ANTI_SOCIAL_BEHAVIOUR", bundle: .module,
                                     comment: "Anti-social behaviour crime category label")

        case .bicycleTheft:
            return NSLocalizedString("CRIME_CATEGORY_BICYCLE_THEFT", bundle: .module,
                                     comment: "Bicycle theft crime category label")

        case .burglary:
            return NSLocalizedString("CRIME_CATEGORY_BURGLARY", bundle: .module,
                                     comment: "Burglary crime category label")

        case .criminalDamageArson:
            return NSLocalizedString("CRIME_CATEGORY_CRIMINAL_DAMAGE_AND_ARSON", bundle: .module,
                                     comment: "Criminal damage and arson crime category label")

        case .drugs:
            return NSLocalizedString("CRIME_CATEGORY_DRUGS", bundle: .module, comment: "Drugs crime category label")

        case .otherTheft:
            return NSLocalizedString("CRIME_CATEGORY_OTHER_THEFT", bundle: .module,
                                     comment: "Other theft crime category label")

        case .possessionOfWeapons:
            return NSLocalizedString("CRIME_CATEGORY_POSSESSION_OF_WEAPONS", bundle: .module,
                                     comment: "Possession of weapons crime category label")

        case .publicOrder:
            return NSLocalizedString("CRIME_CATEGORY_PUBLIC_ORDER", bundle: .module,
                                     comment: "Public order crime category label")

        case .robbery:
            return NSLocalizedString("CRIME_CATEGORY_ROBBERY", bundle: .module,
                                     comment: "Robbery crime category label")

        case .shoplifting:
            return NSLocalizedString("CRIME_CATEGORY_SHOPLIFTING", bundle: .module,
                                     comment: "Shoplifting crime category label")

        case .theftFromThePerson:
            return NSLocalizedString("CRIME_CATEGORY_THEFT_FROM_THE_PERSON", bundle: .module,
                                     comment: "Theft from the person crime category label")

        case .vehicleCrime:
            return NSLocalizedString("CRIME_CATEGORY_VEHICLE_CRIME", bundle: .module,
                                     comment: "Vehicle crime crime category label")

        case .violentCrime:
            return NSLocalizedString("CRIME_CATEGORY_VIOLENCE_OR_SEXUAL_OFFENCE", bundle: .module,
                                     comment: "Violence or sexual offence crime category label")

        case .otherCrime:
            return NSLocalizedString("CRIME_CATEGORY_OTHER_CRIME", bundle: .module,
                                     comment: "Other crime crime category label")
        }
    }

}
