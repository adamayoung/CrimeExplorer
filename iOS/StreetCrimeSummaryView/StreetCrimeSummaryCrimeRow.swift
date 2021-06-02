import CrimeExplorerCore
import SwiftUI

struct StreetCrimeSummaryCrimeRow: View {

    var crime: StreetCrimeSummary.Crime

    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            Circle()
                .fill(crime.category.backgroundColor)
                .frame(width: 32, height: 32)
                .shadow(radius: 3, x: 2, y: 2)
                .overlay(crime.category.image
                            .resizable()
                            .foregroundColor(.white)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20, alignment: .center))

            Text(crime.category.name)
                .font(.headline)
            Spacer()

        }
        .padding()
    }

}

struct StreetCrimeSummaryCrimeRow_Previews: PreviewProvider {

    static var previews: some View {
        StreetCrimeSummaryCrimeRow(crime: StreetCrimeSummary.mocks.first!.crimes.first!)
            .previewLayout(.sizeThatFits)
    }

}
