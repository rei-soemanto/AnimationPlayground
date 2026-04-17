import SwiftUI

class TransformViewModel: ObservableObject {
    // Scaling
    @Published var scaleValue: CGFloat = 1.0
    @Published var isScalingBreathing: Bool = false
    
    // Rotation
    @Published var rotationValue: Double = 0.0
    @Published var isSpinning: Bool = false
    
    // Opacity
    @Published var opacityValue: Double = 1.0
    @Published var isOpacityBreathing: Bool = false
    
    // Hue
    @Published var hueValue: Double = 0.0
    @Published var isHueBreathing: Bool = false
}