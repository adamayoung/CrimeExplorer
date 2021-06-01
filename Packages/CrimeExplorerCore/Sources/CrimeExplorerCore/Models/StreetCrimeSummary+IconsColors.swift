import CoreLocation
import Foundation
import SwiftUI

extension StreetCrimeSummary {

    public var image: Image {
        if crimes.isEmpty {
            return Image(systemName: "questionmark")
        }

        if crimes.count == 1 {
            return crimes[0].category.image
        }

        return Image(systemName: "square.stack.3d.up.fill")
    }

    public var backgroundColor: Color {
        if crimes.isEmpty {
            return .black
        }

        if crimes.count == 1 {
            return crimes[0].category.backgroundColor
        }

        return Color("multipleCrimes", bundle: .module)
    }

}
