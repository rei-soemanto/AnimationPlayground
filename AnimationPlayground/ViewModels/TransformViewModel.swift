//
//  TransformViewModel.swift
//  AnimationPlayground
//
//  Created by Rei Soemanto on 16/04/26.
//

import SwiftUI
import Combine

class TransformViewModel: ObservableObject {
    @Published var scaleValue: Double = 1.0
    @Published var rotationValue: Double = 0.0
    @Published var opacityValue: Double = 1.0
    @Published var hueValue: Double = 0.0
    
    @Published var isScalingBreathing: Bool = false
    @Published var isSpinning: Bool = false
    @Published var isOpacityBreathing: Bool = false
    @Published var isHueBreathing: Bool = false
    
    private var scaleTimer: AnyCancellable?
    private var rotationTimer: AnyCancellable?
    private var opacityTimer: AnyCancellable?
    private var hueTimer: AnyCancellable?
    
    private var baseScale: Double = 1.0
    private var scaleIncreasing = true
    
    private var baseOpacity: Double = 1.0
    private var opacityDecreasing = true
    
    private var hueIncreasing = true
    
    func toggleScale(isActive: Bool) {
        if isActive {
            baseScale = scaleValue
            
            scaleIncreasing = scaleValue < 2.0
            
            scaleTimer = Timer.publish(every: 0.016, on: .main, in: .common).autoconnect().sink { [weak self] _ in
                guard let self = self else { return }
                let step = 0.015
                
                if self.scaleIncreasing {
                    self.scaleValue += step
                    if self.scaleValue >= 2.0 {
                        self.scaleValue = 2.0
                        self.scaleIncreasing = false
                    }
                } else {
                    self.scaleValue -= step
                    if self.scaleValue <= 0.5 {
                        self.scaleValue = 0.5
                        self.scaleIncreasing = true
                    }
                }
            }
        } else {
            scaleTimer?.cancel()
        }
    }
    
    func toggleRotation(isActive: Bool) {
        if isActive {
            rotationTimer = Timer.publish(every: 0.016, on: .main, in: .common).autoconnect().sink { [weak self] _ in
                guard let self = self else { return }
                self.rotationValue += 2.0
                if self.rotationValue > 180 { self.rotationValue = -180 }
            }
        } else {
            rotationTimer?.cancel()
        }
    }
    
    func toggleOpacity(isActive: Bool) {
        if isActive {
            baseOpacity = opacityValue
            opacityDecreasing = true
            opacityTimer = Timer.publish(every: 0.016, on: .main, in: .common).autoconnect().sink { [weak self] _ in
                guard let self = self else { return }
                let step = 0.015
                
                if self.opacityDecreasing {
                    self.opacityValue -= step
                    if self.opacityValue <= 0.0 { self.opacityDecreasing = false }
                } else {
                    self.opacityValue += step
                    if self.opacityValue >= self.baseOpacity { self.opacityDecreasing = true }
                }
            }
        } else {
            opacityTimer?.cancel()
            opacityValue = baseOpacity
        }
    }
    
    func toggleHue(isActive: Bool) {
        if isActive {
            hueTimer = Timer.publish(every: 0.016, on: .main, in: .common).autoconnect().sink { [weak self] _ in
                guard let self = self else { return }
                let step = 3.0 
                
                self.hueValue += step
                
                if self.hueValue >= 360.0 {
                    self.hueValue = 0.0
                }
            }
        } else {
            hueTimer?.cancel()
        }
    }
}
