//
//  ScalingCircle.swift
//  Gesture Examples
//
//  Created by Iiro Alhonen on 25.3.2022.
//

import SwiftUI

struct ScalingCircle: View {

    @State private var circleSize: CGFloat = 150
    @GestureState var dragging: DragState = .inactive
    @State private var tapped: Bool = false

    func tappedCircle() {
        self.tapped = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // Put your code which should be executed with a delay here
            self.tapped = false
        }
    }

    var body: some View {

        let scalingDrag = LongPressGesture(minimumDuration: 0.1)
            .sequenced(before: DragGesture())
            .updating($dragging) { value, state, transaction in
                guard tapped else { return }
                switch value {
                    // Long press begins.
                case .first(true):
                    state = .pressing
                    // Long press confirmed, dragging may begin.
                case .second(true, let drag):
                    state = .dragging(translation: drag?.translation ?? .zero)
                    // Dragging ended or the long press cancelled.
                    if let translationHeight = drag?.translation.height {
                        if (self.circleSize - translationHeight) > 0 {
                            self.circleSize -= translationHeight
                        }
                    }
                default:
                    state = .inactive
                }
            }

        let tapAndScale = TapGesture()
            .onEnded { value in
                print("HEY")
                tappedCircle()
            }

        let magnification = MagnificationGesture()
            .onChanged { value in
                circleSize += value
            }
        
        ZStack {
            Circle()
                .frame(width: circleSize, height: circleSize)
                .foregroundColor(.mint)
            Text("Tap & Drag")
                .font(.title)
        }
        .gesture(tapAndScale)
        .gesture(scalingDrag)
        .gesture(magnification)
    }
}

struct ScalingCircle_Previews: PreviewProvider {
    static var previews: some View {
        ScalingCircle()
    }
}
