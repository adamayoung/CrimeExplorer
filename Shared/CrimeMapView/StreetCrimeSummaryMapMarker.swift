import CrimeExplorerCore
import SwiftUI

struct StreetCrimeSummaryMapMarker: View {

    var summary: StreetCrimeSummary
    var showAnnotationLabels: Bool = true

    @Environment(\.colorScheme) private var colorScheme
    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 0
    private let animation: Animation = .easeOut

    var body: some View {
        VStack {
            Circle()
                .fill(summary.backgroundColor)
                .frame(width: 32, height: 32)
                .shadow(radius: 3, x: 2, y: 2)
                .overlay(image)

            label
                .font(.caption)
                .foregroundColor(summary.backgroundColor)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: 100)
                .shadow(color: colorScheme == .light ? .white : .black, radius: 2)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .opacity(showAnnotationLabels ? 1 : 0)
                .animation(.easeIn)
        }
        .scaleEffect(scale)
        .transition(.opacity)
        .opacity(opacity)
        .animation(animation, value: scale)
        .animation(animation, value: opacity)

        .onAppear(perform: show)
        .onDisappear(perform: hide)
    }

    private var image: some View {
        summary.image
            .resizable()
            .foregroundColor(.white)
            .aspectRatio(contentMode: .fit)
            .frame(width: 20, height: 20, alignment: .center)
    }

    @ViewBuilder private var label: some View {
        if summary.crimes.count == 1 {
            Text(summary.crimes[0].category.name)
        } else {
            Text("CRIME_CATEGORY_MULTIPLE_CRIMES")
        }
    }

    private func show() {
        scale = 1
        opacity = 1
    }

    private func hide() {
        scale = 0.5
        opacity = 0
    }

}

struct StreetCrimeSummaryMapMarker_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            ForEach(StreetCrimeSummary.mocks, id: \.self) {
                StreetCrimeSummaryMapMarker(summary: $0, showAnnotationLabels: true)
                    .previewLayout(.sizeThatFits)
            }

        }
    }

}
