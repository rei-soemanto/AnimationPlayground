import SwiftUI

class PhysicsViewModel: ObservableObject {
    // Spring Effect
    @Published var springOffset: CGFloat = 0.0
    
    // Particle Burst
    @Published var particles: [Particle] = []
    
    // Stagger Reveal
    @Published var cardVisibility: [Bool] = Array(repeating: false, count: 9)
    let staggerColors: [Color] = [.red, .orange, .yellow, .green, .cyan, .blue, .purple, .pink, .red.opacity(0.7)]
    
    // Morph Shape
    @Published var morphAmount: CGFloat = 0.0
    
    // 3D Card Flip
    @Published var isCardFlipped: Bool = false
    
    func launchSpring() {
        // Teleport to the right instantly
        springOffset = 150
        
        // Spring back to original position
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            withAnimation(.interpolatingSpring(stiffness: 100, damping: 5)) {
                self.springOffset = 0
            }
        }
    }
    
    func burstParticles() {
        let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple]
        var newParticles: [Particle] = []
        
        for _ in 0..<20 {
            let p = Particle(
                x: CGFloat.random(in: -100...100),
                y: CGFloat.random(in: -100...100),
                color: colors.randomElement() ?? .blue,
                scale: CGFloat.random(in: 0.2...1.0),
                opacity: 1.0
            )
            newParticles.append(p)
        }
        
        particles = newParticles
        
        // Fade and move out
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            withAnimation(.easeOut(duration: 1.0)) {
                for i in 0..<self.particles.count {
                    self.particles[i].x *= 1.5
                    self.particles[i].y *= 1.5
                    self.particles[i].opacity = 0
                }
            }
        }
    }
    
    func toggleStaggerReveal(show: Bool) {
        // 3x3 Grid, calculating diagonal delay based on row + col
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