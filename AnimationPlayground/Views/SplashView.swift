//
//  SplashView.swift
//  AnimationPlayground
//
//  Created by Rei Soemanto on 16/04/26.
//

import SwiftUI

struct SplashView: View {
    @Binding var isActive: Bool
    
    @State private var bgRotation: Double = 0
    @State private var logoScale: CGFloat = 0.1
    @State private var logoRotation: Double = -180
    @State private var textOpacity: Double = 0
    @State private var buttonOpacity: Double = 0
    @State private var isBreathing: Bool = false
    
    var body: some View {
        ZStack {
            AngularGradient(
                gradient: Gradient(colors: [.purple, .blue, .teal, .purple]),
                center: .center,
                angle: .degrees(bgRotation)
            )
            .ignoresSafeArea()
            .onAppear {
                withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
                    bgRotation = 360
                }
            }
            
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                
            Image(systemName: "sparkles")
                .font(.system(size: 80))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.white, .cyan],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .shadow(color: .white.opacity(10), radius: 20)
                .scaleEffect(logoScale)
                .rotationEffect(.degrees(logoRotation))
            
            VStack(spacing: 8) {
                Text("Animation")
                    .font(.custom("AvenirNext-Heavy", size: 40))
                        .bold()
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.white, .cyan],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                Text("Playground")
                    .font(.title3).bold()
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.white, .cyan],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
            }
            .foregroundColor(.white)
            .opacity(textOpacity)
            .offset(y: 100)
                
            VStack {
                Spacer()
                
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.6)) { isActive = false }
                }) {
                    HStack {
                        Text("Enter Playground")
                        Image(systemName: "arrow.right.circle.fill")
                    }
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding()
                    .padding(.horizontal, 10)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .shadow(color: .cyan.opacity(isBreathing ? 1.0 : 0.0), radius: isBreathing ? 30 : 0)
                    .scaleEffect(isBreathing ? 1.05 : 1.0)
                }
                .opacity(buttonOpacity)
                .padding(.bottom, 50)
            }
            
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.6).delay(0.2)) {
                logoScale = 1.0
                logoRotation = 0
            }
            withAnimation(.easeIn(duration: 0.5).delay(1.0)) {
                textOpacity = 1.0
            }
            withAnimation(.easeIn(duration: 0.5).delay(1.5)) {
                buttonOpacity = 1.0
            }
            withAnimation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true).delay(2.0)) {
                isBreathing = true
            }
        }
    }
}

#Preview {
    SplashView(isActive: .constant(true))
}
