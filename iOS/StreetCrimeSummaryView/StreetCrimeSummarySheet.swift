import CrimeExplorerCore
import SwiftUI

struct StreetCrimeSummarySheet: View {

    @Binding var state: BottomSheetState
    var height: CGFloat

    @EnvironmentObject private var model: AppModel

    var body: some View {
        BottomSheetView(state: $state, maxHeight: height, header: header) {
            StreetCrimeSummaryView(
                neighbourhood: model.currentNeighbourhood,
                streetCrimeSummary: model.selectedStreetCrimeSummary
            )
        }
        .onReceive(model.$selectedStreetCrimeSummary.delay(for: .milliseconds(200),
                                                           scheduler: DispatchQueue.main)) { summary in
            guard summary != nil else {
                return
            }

            if state == .closed {
                state = .halfOpen
            }
        }
    }

    private var header: some View {
        Text(model.currentNeighbourhood?.name ?? " ")
            .frame(maxWidth: .infinity)
            .font(.headline)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
    }

}

struct StreetCrimeSummarySheet_Previews: PreviewProvider {

    static var previews: some View {
        StreetCrimeSummarySheet(state: .constant(.open), height: 500)
            .environmentObject(AppModel.mock)
            .previewLayout(.sizeThatFits)
    }

}
