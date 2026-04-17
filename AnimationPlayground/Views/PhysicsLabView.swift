//
//  PhysicsLabView.swift
//  AnimationPlayground
//
//  Created by Rei Soemanto on 16/04/26.
//

import SwiftUI

struct PhysicsLabView: View {
    @StateObject private var vm = PhysicsViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    
                    SectionView(title: "Spring Effect", icon: "tornado") {
                        VStack(spacing: 20) {
                            GeometryReader { geo in
                                ZStack(alignment: .leading) {
                                    Capsule()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(height: 12)
                                    
                                    Circle()
                                        .fill(Color.purple)
                                        .frame(width: 35, height: 35)
                                        .offset(x: vm.springOffset)
                                }
                                .frame(height: 35)
                                .onAppear {
                                    vm.maxSpringDistance = geo.size.width - 35
                                }
                            }
                            .frame(height: 35)
                            
                            Button("Launch Spring") {
                                vm.launchSpring()
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.purple)
                            .buttonBorderShape(.capsule)
                        }
                    }
                    
                    SectionView(title: "Particle Burst", icon: "burst.fill") {
                        VStack {
                            ZStack {
                                Rectangle()
                                    .fill(Color(UIColor.systemGray6))
                                    .frame(height: 150)
                                    .cornerRadius(10)
                                
                                ForEach(vm.particles) { particle in
                                    Circle()
                                        .fill(particle.color)
                                        .frame(width: 20 * particle.scale, height: 20 * particle.scale)
                                        .offset(x: particle.x, y: particle.y)
                                        .opacity(particle.opacity)
                                }
                            }
                            
                            Button("🎉 Burst!") {
                                vm.burstParticles()
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.pink)
                            .buttonBorderShape(.capsule)
                        }
                    }
                    
                    SectionView(title: "Stagger Reveal", icon: "square.grid.3x2.fill") {
                        VStack {
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
                                    .buttonBorderShape(.capsule)
                                
                                Button("Hide") { vm.toggleStaggerReveal(show: false) }
                                    .buttonStyle(.borderedProminent).tint(.gray)
                                    .buttonBorderShape(.capsule)
                            }
                        }
                    }
                    
                    SectionView(title: "Morph Shape", icon: "seal.fill") {
                        VStack {
                            MorphingPolygon(morphAmount: vm.morphAmount)
                                .fill(LinearGradient(colors: [.cyan, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(width: 100, height: 100)
                                .animation(.easeInOut, value: vm.morphAmount)
                            
                            Slider(value: $vm.morphAmount, in: 0...1)
                                .accentColor(.purple)
                        }
                    }
                    
                    SectionView(title: "3D Flip Card", icon: "arrow.trianglehead.left.and.right.righttriangle.left.righttriangle.right") {
                        VStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(LinearGradient(colors: [.orange, .red], startPoint: .leading, endPoint: .trailing))
                                    .frame(height: 120)
                                    .overlay(VStack { Image(systemName: "checkmark.seal.fill"); Text("Back") }.foregroundColor(.white))
                                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                                    .opacity(vm.isCardFlipped ? 1 : 0)
                                
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
                            .buttonBorderShape(.capsule)
                        }
                    }
                }
                .padding()
            }
            .background(Color(UIColor.systemGray6))
            .navigationTitle("Physics Lab")
        }
    }
}

#Preview {
    PhysicsLabView()
}
