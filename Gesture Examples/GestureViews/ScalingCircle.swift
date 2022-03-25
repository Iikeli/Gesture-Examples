//
//  ScalingCircle.swift
//  Gesture Examples
//
//  Created by Iiro Alhonen on 25.3.2022.
//

import SwiftUI

struct ScalingCircle: View {
    @State private var circleSize: CGFloat = 150

    var body: some View {
        ZStack {
            Circle()
                .frame(width: circleSize, height: circleSize)
            .foregroundColor(.mint)
            Text("Tap & Drag")
                .font(.title)
        }
    }
}

struct ScalingCircle_Previews: PreviewProvider {
    static var previews: some View {
        ScalingCircle()
    }
}
