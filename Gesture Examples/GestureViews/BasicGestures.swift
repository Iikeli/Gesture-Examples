//
//  BasicGestures.swift
//  Gesture Examples
//
//  Created by Iiro Alhonen on 25.3.2022.
//

import SwiftUI

struct BasicGestures: View {

    @State private var tapped: Bool = false
    @State private var doubleTapped: Bool = false
    @State private var longPressed: Bool = false
    @State private var longPressInProgress: Bool = false
    @GestureState var longPress: Bool = false

    var body: some View {
        let tap = TapGesture()
            .onEnded { _ in
                tapped.toggle()
            }

        let doubleTap = TapGesture(count: 2)
            .onEnded { _ in
                doubleTapped.toggle()
            }

        let longPress = LongPressGesture(minimumDuration: 5)
            .updating($longPress) { currentState, gestureState, transaction in
                print("Long press: \(currentState)")
                gestureState = currentState
            }.onChanged { _ in
                print("Changed")
                //longPressed.toggle()
            }

        VStack {
            ZStack {
                Circle()
                    .frame(width: 200, height: 200)
                    .foregroundColor(tapped ? .mint : .cyan)
                Text("Tap me")
                    .font(.title)
            }.gesture(tap)

            ZStack {
                Circle()
                    .frame(width: 200, height: 200)
                    .foregroundColor(doubleTapped ? .mint : .cyan)
                Text("Double tap")
                    .font(.title)
            }.gesture(doubleTap)

            ZStack {
                Circle()
                    .frame(width: 200, height: 200)
                    .foregroundColor(longPressInProgress ? .red : (longPressed ? .mint : .cyan))
                Text("Long press")
                    .font(.title)
            }
            .onLongPressGesture(minimumDuration: 1, maximumDistance: 100, perform: {
                print("Gesture")
                longPressed.toggle()
            }, onPressingChanged: { trigg in
                print(trigg)
                longPressInProgress = trigg
            })
        }

    }
}
