import SwiftUI

struct PhysicsLabView: View {
    @StateObject private var vm = PhysicsViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    
                    // 1. Spring Effect
                    SectionView(title: "Spring Effect", icon: "tornado") {
                        HStack {
                            Circle()
                                .fill(Color.purple)
                                .frame(width: 40, height: 40)
                                .offset(x: vm.springOffset)
                            Spacer()
                        }
                        .frame(height: 50)
                        Button("Launch Spring") {
                            vm.launchSpring()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.purple)
                    }
                    
                    // 2. Particle Burst
                    SectionView(title: "Particle Burst", icon: "sun.max") {
                        ZStack {
                            Rectangle()
                                .fill(Color.gray.opacity(0.1))
                                .frame(height: 120)
                                .cornerRadius(10)
                            
                            ForEach(vm.particles) { particle in
                                Circle()
                                    .fill(particle.color)
                                    .frame(width: 20 * particle.scale, height: 20 * particle.scale)
                                    .offset(x: particle.x, y: particle.y)
                                    .opacity(particle.opacity)
                            }
                        }
                        Button("Burst!") {
                            vm.burstParticles()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.pink)
                    }
                    
                    // 3. Stagger Reveal
                    SectionView(title: "Stagger Reveal", icon: "square.grid.3x3") {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 10) {
                            ForEach(0..<9, id: \.self) { index in
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(vm.staggerColors[index])
                                    .frame(height: 60)
                                    .opacity(vm.cardVisibility[index] ? 1 : 0)
                                    .scaleEffect(vm.cardVisibility[index] ? 1 : 0.5)
                            }
                        }
                        HStack {
                            Button("Reveal") { vm.toggleStaggerReveal(show: true) }
                                .buttonStyle(.borderedProminent).tint(.green)
                            Button("Hide") { vm.toggleStaggerReveal(show: false) }
                                .buttonStyle(.borderedProminent).tint(.gray)
                        }
                    }
                    
                    // 4. Morph Shape
                    SectionView(title: "Morph Shape", icon: "hexagon") {
                        MorphingPolygon(morphAmount: vm.morphAmount)
                            .fill(LinearGradient(colors: [.cyan, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(width: 100, height: 100)
                            .animation(.easeInOut, value: vm.morphAmount)
                        
                        Slider(value: $vm.morphAmount, in: 0...1)
                            .accentColor(.purple)
                    }
                    
                    // 5. 3D Card Flip
                    SectionView(title: "3D Flip Card", icon: "creditcard") {
                        ZStack {
                            // Back of Card
                            RoundedRectangle(cornerRadius: 15)
                                .fill(LinearGradient(colors: [.orange, .red], startPoint: .leading, endPoint: .trailing))
                                .frame(height: 120)
                                .overlay(VStack { Image(systemName: "checkmark.seal.fill"); Text("Back") }.foregroundColor(.white))
                                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                                .opacity(vm.isCardFlipped ? 1 : 0)
                            
                            // Front of Card
                            RoundedRectangle(cornerRadius: 15)
                                .fill(LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing))
                                .frame(height: 120)
                                .overlay(VStack { Image(systemName: "creditcard.fill"); Text("Front") }.foregroundColor(.white))
                                .opacity(vm.isCardFlipped ? 0 : 1)
                        }
                        .rotation3DEffect(.degrees(vm.isCardFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
                        .animation(.spring(response: 0.6, dampingFraction: 0.8), value: vm.isCardFlipped)
                        
                        Button(vm.isCardFlipped ? "Flip Back" : "Flip Card") {
                            vm.isCardFlipped.toggle()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(vm.isCardFlipped ? .orange : .blue)
                    }
                }
                .padding()
            }
            .navigationTitle("Physics Lab")
        }
    }
}

// Reusable Section Wrapper
struct SectionView<Content: View>: View {
    let title: String
    let icon: String
    let content: Content
    
    init(title: String, icon: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.icon = icon
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Label(title, systemImage: icon)
                .font(.headline)
            content
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }
}