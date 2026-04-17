//
//  PhysicsViewModel.swift
//  AnimationPlayground
//
//  Created by Rei Soemanto on 16/04/26.
//

import SwiftUI
import Combine

class PhysicsViewModel: ObservableObject {
    @Published var springOffset: CGFloat = 0.0
    
    @Published var maxSpringDistance: CGFloat = 200.0
    
    @Published var particles: [Particle] = []
    
    @Published var cardVisibility: [Bool] = Array(repeating: false, count: 9)
    let staggerColors: [Color] = [.red, .orange, .yellow, .green, .cyan, .blue, .indigo, .purple, .pink]
    
    @Published var morphAmount: CGFloat = 0.0
    
    @Published var isCardFlipped: Bool = false
    
    func launchSpring() {
        springOffset = maxSpringDistance
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.4)) {
                self.springOffset = 0
            }
        }
    }
    
    func burstParticles() {
        let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple]
        var newParticles: [Particle] = []
        
        for _ in 0..<20 {
            let p = Particle(
                x: 0,
                y: 0,
                color: colors.randomElement() ?? .blue,
                scale: 0.0,
                opacity: 1.0
            )
            newParticles.append(p)
        }
        
        particles = newParticles
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            withAnimation(.easeOut(duration: 0.4)) {
                for i in 0..<self.particles.count {
                    self.particles[i].x = CGFloat.random(in: -120...120)
                    self.particles[i].y = CGFloat.random(in: -120...120)
                    self.particles[i].scale = CGFloat.random(in: 0.5...1.5)
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
            withAnimation(.easeIn(duration: 0.5)) {
                for i in 0..<self.particles.count {
                    self.particles[i].x *= 1.2
                    self.particles[i].y *= 1.2
                    self.particles[i].opacity = 0
                    self.particles[i].scale = 0.1
                }
            }
        }
    }
    
    func toggleStaggerReveal(show: Bool) {
        for index in 0..<9 {
            let row = index / 3
            let col = index % 3
            let delay = Double(row + col) * 0.15
            
            withAnimation(.easeInOut(duration: 0.4).delay(delay)) {
                cardVisibility[index] = show
            }
        }
    }
}
