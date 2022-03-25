import SwiftUI

struct DraggableCircle: View {

    @GestureState var dragState = DragState.inactive
    @State private var isDraggable: Bool = false
    @State private var viewState = CGSize.zero

    var body: some View {
        let minimumLongPressDuration = 0.5
        let longPressDrag = LongPressGesture(minimumDuration: minimumLongPressDuration)
            .sequenced(before: DragGesture())
            .updating($dragState) { value, state, transaction in
                print(state)
                switch value {
                    // Long press begins.
                case .first(true):
                    state = .pressing
                    isDraggable = true
                    // Long press confirmed, dragging may begin.
                case .second(true, let drag):
                    state = .dragging(translation: drag?.translation ?? .zero)
                    // Dragging ended or the long press cancelled.
                default:
                    state = .inactive
                    isDraggable = false
                }
//                if state != .pressing || state != .dragging {
//                    isDraggable = false
//                }
            }
            .onEnded { value in
                guard case .second(true, let drag?) = value else { return }
                self.viewState.width += drag.translation.width
                self.viewState.height += drag.translation.height
                isDraggable = false
            }

        return ZStack {
            Circle()
                .foregroundColor(.mint)
                .animation(.interpolatingSpring(mass: 10, stiffness: 100, damping: 10, initialVelocity: 100), value: dragState.isActive)
                .frame(width: isDraggable ? 165 : 150, height: isDraggable ? 165 : 150, alignment: .center)
                .shadow(radius: dragState.isActive ? 8 : 0)
                .animation(.linear(duration: minimumLongPressDuration), value: dragState.isActive)
            Text("Drag me")
                .font(.title)
        }
        .offset(
            x: viewState.width + dragState.translation.width,
            y: viewState.height + dragState.translation.height
        )
        .gesture(longPressDrag)
    }
}
