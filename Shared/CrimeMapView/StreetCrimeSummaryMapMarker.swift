import CrimeExplorerCore
import SwiftUI

struct StreetCrimeSummaryMapMarker: View {

    var summary: StreetCrimeSummary
    var showAnnotationLabels: Bool = true
    var onTap: () -> Void

    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 0
    private let animation: Animation = .easeOut
    private var badgeSize: CGSize {
        #if os(watchOS)
        CGSize(width: 20, height: 20)
        #else
        CGSize(width: 32, height: 32)
        #endif
    }
    private var labelFont: Font {
        #if os(watchOS)
        Font.system(size: 10)
        #else
        Font.caption
        #endif
    }

    var body: some View {
        VStack {
            CrimeBadge(summary: summary)
                .frame(width: badgeSize.width, height: badgeSize.height)

            label
                .font(.system(size: 10))
                .bold()
                .minimumScaleFactor(0.5)
                .foregroundColor(summary.backgroundColor)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: 100)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .opacity(showAnnotationLabels ? 1 : 0)
                .animation(.easeIn)
        }
        .accessibilityElement(children: .ignore)
        .accessibility(label: accessibilityLabel)
        .accessibility(identifier: "streetCrimeSummaryMapMarker-\(summary.id)")
        .scaleEffect(scale)
        .transition(.opacity)
        .opacity(opacity)
        .animation(animation, value: scale)
        .animation(animation, value: opacity)
        .onAppear(perform: didAppear)
        .onDisappear(perform: didDisappear)
        .onTapGesture(perform: onTap)
    }

    private var label: Text {
        if summary.crimes.count == 1 {
            return Text(summary.crimes[0].category.name)
        }

        return Text("CRIME_CATEGORY_MULTIPLE_CRIMES")
    }

    private var accessibilityLabel: Text {
        if summary.crimes.count == 1 {
            return Text("CRIME_CATEGORY_\(summary.crimes[0].category.name)_AT_LOCATION_NAME_\(summary.name)")
        }

        return Text("CRIME_CATEGORY_MULTIPLE_CRIMES_AT_LOCATION_NAME_\(summary.name)")
    }

    private func didAppear() {
        scale = 1
        opacity = 1
    }

    private func didDisappear() {
        scale = 0.5
        opacity = 0
    }

}

struct StreetCrimeSummaryMapMarker_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            ForEach(StreetCrimeSummary.mocks, id: \.self) {
                StreetCrimeSummaryMapMarker(summary: $0, showAnnotationLabels: true, onTap: {})
                    .previewLayout(.sizeThatFits)
            }

        }
    }

}
