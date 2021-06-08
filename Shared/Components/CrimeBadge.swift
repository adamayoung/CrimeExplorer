import CrimeExplorerCore
import SwiftUI

struct CrimeBadge: View {

    var color: Color
    var image: Image

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .fill(color)

                image
                    .resizable()
                    .foregroundColor(.white)
                    .aspectRatio(contentMode: .fit)
                    .padding(geometry.size.width / 5)
            }
        }
    }

}

extension CrimeBadge {

    init(summary: StreetCrimeSummary) {
        self.init(color: summary.backgroundColor, image: summary.image)
    }

    init(category: CrimeCategory) {
        self.init(color: category.backgroundColor, image: category.image)
    }

}

struct CrimeBadge_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            CrimeBadge(color: .red, image: Image(systemName: "house.fill"))
                .frame(width: 30, height: 30)

            CrimeBadge(color: .red, image: Image(systemName: "house.fill"))
                .frame(width: 60, height: 60)
        }
        .previewLayout(.sizeThatFits)
    }

}
