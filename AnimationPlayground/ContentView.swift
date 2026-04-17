//
//  ContentView.swift
//  AnimationPlayground
//
//  Created by Rei Soemanto on 16/04/26.
//

import SwiftUI

struct ContentView: View {
    @State private var isSplashActive = true
    
    var body: some View {
        Group {
            if isSplashActive {
                SplashView(isActive: $isSplashActive)
            } else {
                TabView {
                    TransformLabView()
                        .tabItem {
                            Label("Transform Lab", systemImage: "wand.and.stars")
                        }
                    
                    PhysicsLabView()
                        .tabItem {
                            Label("Physics Lab", systemImage: "bolt.circle.fill")
                        }
                }
                .tint(.purple)
            }
        }
    }
}

#Preview {
    ContentView()
}
