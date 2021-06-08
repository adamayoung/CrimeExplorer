import CrimeExplorerCore
import SwiftUI

struct StreetCrimeSummaryView: View {

    var neighbourhood: Neighbourhood?
    var streetCrimeSummary: StreetCrimeSummary?

    var body: some View {
        LazyVStack(alignment: .leading) {
            Text(streetCrimeSummary?.name ?? " ")
                .frame(maxWidth: .infinity)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            if let streetCrimeSummary = streetCrimeSummary {
                ForEach(streetCrimeSummary.crimes) { crime in
                    StreetCrimeSummaryCrimeRow(crime: crime)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }

}

struct StreetCrimeSummaryView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            StreetCrimeSummaryView(streetCrimeSummary: .mocks.first)
                .previewLayout(.sizeThatFits)

            StreetCrimeSummaryView(streetCrimeSummary: nil)
                .previewLayout(.sizeThatFits)
        }
    }

}
