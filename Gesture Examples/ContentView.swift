//
//  ContentView.swift
//  Gesture Examples
//
//  Created by Iiro Alhonen on 25.3.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            BasicGestures()
                .tabItem {
                    Label("Basic", systemImage: "pin")
                }
            DraggableCircle()
                .tabItem {
                    Label("Drag", systemImage: "arrow.up.and.down.and.arrow.left.and.right")
                }
            ScalingCircle()
                .tabItem {
                    Label("Scale", systemImage: "arrow.up.and.down")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
