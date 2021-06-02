import SwiftUI

struct BottomSheetView<Header: View, Content: View>: View {

    @Binding var state: BottomSheetState
    var maxHeight: CGFloat
    var header: Header
    var content: () -> Content

    @GestureState private var dragState: DragState = .inactive
    private var dragGesture: some Gesture {
        DragGesture()
            .updating($dragState) { drag, state, _ in
                state = .dragging(translation: drag.translation)
            }
            .onEnded(onDragEnded)
    }

    private var yOffset: CGFloat {
        height(for: state) + self.dragState.translation.height
    }

    private var animation: Animation? {
        if dragState.isDragging {
            return nil
        }

        return .interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0)
    }

    private var contentOpacity: Double {
        switch dragState {
        case .inactive:
            switch state {
            case .closed:
                return 0

            case .halfOpen, .open:
                return 1
            }

        case .dragging(let translation):
            let closedHeight = height(for: .closed) - 100
            let currentHeight = height(for: state) + translation.height
            let heightUntilClosed = closedHeight - currentHeight

            if heightUntilClosed < 0 {
                return 0
            }

            let opacity = Double(heightUntilClosed) / 150.0
            return opacity < 1 ? opacity : 1
        }
    }

    var body: some View {
        VStack {
            Handle()
                .padding(.top)
                .padding(.bottom, 16)

//            ScrollView {
                if let header = header {
                    header
                }

                content()
                    .opacity(contentOpacity)

                Spacer()
//            }
        }
        .frame(height: maxHeight * 1.2)
        .backgroundVisualEffect()
        .cornerRadius(10.0)
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
        .offset(y: yOffset)
        .animation(animation, value: yOffset)
        .gesture(dragGesture)
    }

    private func onDragEnded(drag: DragGesture.Value) {
        let verticalDirection = drag.predictedEndLocation.y - drag.location.y
        let topEdgeLocation = height(for: state) + drag.translation.height
        let positionAbove: BottomSheetState
        let positionBelow: BottomSheetState
        let closestPosition: BottomSheetState

        if topEdgeLocation <= height(for: .halfOpen) {
            positionAbove = .open
            positionBelow = .halfOpen
        } else {
            positionAbove = .halfOpen
            positionBelow = .closed
        }

        if (topEdgeLocation - height(for: positionAbove)) < (height(for: positionBelow) - topEdgeLocation) {
            closestPosition = positionAbove
        } else {
            closestPosition = positionBelow
        }

        if verticalDirection > 0 {
            self.state = positionBelow
        } else if verticalDirection < 0 {
            self.state = positionAbove
        } else {
            self.state = closestPosition
        }
    }

    private func height(for state: BottomSheetState) -> CGFloat {
        switch state {
        case .open:
            return maxHeight - (maxHeight - 100)

        case .halfOpen:
            return maxHeight / 2

        case .closed:
            return maxHeight - 100
        }
    }

}

extension BottomSheetView {

    enum DragState: Equatable {
        case inactive
        case dragging(translation: CGSize)

        var translation: CGSize {
            switch self {
            case .inactive:
                return .zero

            case .dragging(let translation):
                return translation
            }
        }

        var isDragging: Bool {
            switch self {
            case .inactive:
                return false

            case .dragging:
                return true
            }
        }
    }

}

enum BottomSheetState {
    case open
    case halfOpen
    case closed
}

struct BottomSheetView_Previews: PreviewProvider {

    static var previews: some View {
        let header = Text("Header")

        return BottomSheetView(state: .constant(.open), maxHeight: 500, header: header) {
            Text("hello")
        }
    }

}

private struct Handle: View {

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.secondary)
            .frame(width: 100, height: 5)
    }

}
