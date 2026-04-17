import SwiftUI

struct TransformLabView: View {
    @StateObject private var vm = TransformViewModel()
    
    // Internal animation states for continuous toggles
    @State private var continuousScale: CGFloat = 1.0
    @State private var continuousRotation: Double = 0.0
    @State private var continuousOpacity: Double = 1.0
    @State private var continuousHue: Double = 0.0
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    
                    // Main Preview Object
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.blue.gradient)
                            .frame(width: 120, height: 120)
                        Image(systemName: "star.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 50))
                    }
                    .frame(height: 250)
                    // Apply all transformations together
                    .scaleEffect(vm.scaleValue * continuousScale)
                    .rotationEffect(.degrees(vm.rotationValue + continuousRotation))
                    .opacity(vm.opacityValue * continuousOpacity)
                    .hueRotation(.degrees(vm.hueValue + continuousHue))
                    
                    // Controls
                    VStack(spacing: 25) {
                        effectControl(title: "Scale", icon: "arrow.up.left.and.down.right.and.arrow.up.right.and.down.left", sliderVal: $vm.scaleValue, sliderRange: 0.5...2.0, toggle: $vm.isScalingBreathing)
                        
                        effectControl(title: "Rotation", icon: "arrow.triangle.2.circlepath", sliderVal: $vm.rotationValue, sliderRange: -180...180, toggle: $vm.isSpinning)
                        
                        effectControl(title: "Opacity", icon: "circle.lefthalf.filled", sliderVal: $vm.opacityValue, sliderRange: 0.0...1.0, toggle: $vm.isOpacityBreathing)
                        
                        effectControl(title: "Hue Effect", icon: "paintpalette", sliderVal: $vm.hueValue, sliderRange: 0...360, toggle: $vm.isHueBreathing)
                    }
                    .padding()
                }
            }
            .navigationTitle("Transform Lab")
            .onChange(of: vm.isScalingBreathing) { isBreathing in
                if isBreathing {
                    withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) { continuousScale = 1.2 }
                } else {
                    withAnimation { continuousScale = 1.0 }
                }
            }
            .onChange(of: vm.isSpinning) { isSpinning in
                if isSpinning {
                    withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: false)) { continuousRotation = 360.0 }
                } else {
                    withAnimation { continuousRotation = 0.0 }
                }
            }
            .onChange(of: vm.isOpacityBreathing) { isBreathing in
                if isBreathing {
                    withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) { continuousOpacity = 0.0 }
                } else {
                    withAnimation { continuousOpacity = 1.0 }
                }
            }
            .onChange(of: vm.isHueBreathing) { isBreathing in
                if isBreathing {
                    withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) { continuousHue = 360.0 }
                } else {
                    withAnimation { continuousHue = 0.0 }
                }
            }
        }
    }
    
    // Reusable UI Component for Controls
    @ViewBuilder
    func effectControl(title: String, icon: String, sliderVal: Binding<Double>, sliderRange: ClosedRange<Double>, toggle: Binding<Bool>) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Label(title, systemImage: icon).font(.headline)
                Spacer()
                Toggle("", isOn: toggle).labelsHidden()
            }
            Slider(value: sliderVal, in: sliderRange)
                .accentColor(.purple)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
    
    // Reusable for CGFloat (Scale)
    @ViewBuilder
    func effectControl(title: String, icon: String, sliderVal: Binding<CGFloat>, sliderRange: ClosedRange<CGFloat>, toggle: Binding<Bool>) -> some View {
        let doubleBinding = Binding<Double>(
            get: { Double(sliderVal.wrappedValue) },
            set: { sliderVal.wrappedValue = CGFloat($0) }
        )
        effectControl(title: title, icon: icon, sliderVal: doubleBinding, sliderRange: Double(sliderRange.lowerBound)...Double(sliderRange.upperBound), toggle: toggle)
    }
}