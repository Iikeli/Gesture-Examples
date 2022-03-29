import SwiftUI

struct DraggableCircle: View {

    @GestureState var dragState = DragState.inactive
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
                    // Long press confirmed, dragging may begin.
                case .second(true, let drag):
                    state = .dragging(translation: drag?.translation ?? .zero)
                    // Dragging ended or the long press cancelled.
                default:
                    state = .inactive
                }
            }
            .onEnded { value in
                guard case .second(true, let drag?) = value else { return }
                self.viewState.width += drag.translation.width
                self.viewState.height += drag.translation.height
            }

        return ZStack {
            Circle()
                .foregroundColor(.mint)
                .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5), value: dragState.isActive)
                .frame(width: dragState.isActive ? 165 : 150, height: dragState.isActive ? 165 : 150, alignment: .center)
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
