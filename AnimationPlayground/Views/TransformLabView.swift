//
//  TransformLabView.swift
//  AnimationPlayground
//
//  Created by Rei Soemanto on 16/04/26.
//

import SwiftUI

struct TransformLabView: View {
    @StateObject private var vm = TransformViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(UIColor.systemGray5))
                            .frame(height: 200)
                            .padding(.horizontal)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(
                                    LinearGradient(
                                        colors: [Color.blue, Color.purple],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 120, height: 120)
                            
                            Image(systemName: "star.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 55))
                        }
                        .scaleEffect(vm.scaleValue)
                        .rotationEffect(.degrees(vm.rotationValue))
                        .opacity(vm.opacityValue)
                        .hueRotation(.degrees(vm.hueValue))
                    }
                    
                    VStack(spacing: 25) {
                        EffectControlView(title: "Scale", icon: "arrow.up.left.and.arrow.down.right", sliderVal: $vm.scaleValue, sliderRange: 0.5...2.0, toggle: $vm.isScalingBreathing, sliderColor: .purple)
                        
                        EffectControlView(title: "Rotation", icon: "arrow.triangle.2.circlepath", sliderVal: $vm.rotationValue, sliderRange: -180...180, toggle: $vm.isSpinning, sliderColor: .blue)
                        
                        EffectControlView(title: "Opacity", icon: "circle.lefthalf.filled", sliderVal: $vm.opacityValue, sliderRange: 0.0...1.0, toggle: $vm.isOpacityBreathing, sliderColor: .orange)
                        
                        EffectControlView(title: "Hue Effect", icon: "paintpalette.fill", sliderVal: $vm.hueValue, sliderRange: 0...360, toggle: $vm.isHueBreathing, sliderColor: .blue)
                    }
                    .padding()
                }
            }
            .background(Color(UIColor.systemGray6))
            .navigationTitle("Transform Lab")
            
            .onChange(of: vm.isScalingBreathing) { isActive in vm.toggleScale(isActive: isActive) }
            .onChange(of: vm.isSpinning) { isActive in vm.toggleRotation(isActive: isActive) }
            .onChange(of: vm.isOpacityBreathing) { isActive in vm.toggleOpacity(isActive: isActive) }
            .onChange(of: vm.isHueBreathing) { isActive in vm.toggleHue(isActive: isActive) }
        }
    }
}

#Preview {
    TransformLabView()
}
