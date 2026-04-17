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
    @State private var buttonBreathingScale: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            // Rotating Background
            AngularGradient(gradient: Gradient(colors: [.purple, .blue, .teal, .purple]), center: .center, angle: .degrees(bgRotation))
                .ignoresSafeArea()
                .onAppear {
                    withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
                        bgRotation = 360
                    }
                }
            
            VStack(spacing: 20) {
                Spacer()
                
                // Logo
                Image(systemName: "sparkles")
                    .font(.system(size: 80))
                    .foregroundColor(.white)
                    .scaleEffect(logoScale)
                    .rotationEffect(.degrees(logoRotation))
                
                // Titles
                VStack(spacing: 8) {
                    Text("Animation")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    Text("Playground")
                        .font(.title3)
                }
                .foregroundColor(.white)
                .opacity(textOpacity)
                
                Spacer()
                
                // Enter Button
                Button(action: {
                    withAnimation { isActive = false }
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
                    .shadow(color: .white.opacity(0.8), radius: 10)
                    .scaleEffect(buttonBreathingScale)
                }
                .opacity(buttonOpacity)
                .padding(.bottom, 50)
            }
        }
        .onAppear {
            // Sequence Animations
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
            // Button breathing loop
            withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true).delay(2.0)) {
                buttonBreathingScale = 1.1
            }
        }
    }
}