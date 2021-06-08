import CrimeExplorerCore
import SwiftUI

struct StreetCrimeSummaryCrimeRow: View {

    var crime: StreetCrimeSummary.Crime

    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            CrimeBadge(category: crime.category)
                .frame(width: 30, height: 30)

            Text(crime.category.name)
                .font(.headline)
                .padding(.leading, 5)
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
