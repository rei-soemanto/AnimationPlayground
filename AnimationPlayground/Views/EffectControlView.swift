//
//  EffectControlView.swift
//  AnimationPlayground
//
//  Created by Rei Soemanto on 16/04/26.
//

import SwiftUI

struct EffectControlView: View {
    let title: String
    let icon: String
    @Binding var sliderVal: Double
    let sliderRange: ClosedRange<Double>
    @Binding var toggle: Bool
    let sliderColor: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Label(title, systemImage: icon).font(.headline)
                Spacer()
                Toggle("", isOn: $toggle).labelsHidden()
            }
            Slider(value: $sliderVal, in: sliderRange)
                .accentColor(sliderColor)
        }
        .padding()
        .background(Color.white)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
        .cornerRadius(12)
    }
}

extension EffectControlView {
    init(title: String, icon: String, sliderVal: Binding<CGFloat>, sliderRange: ClosedRange<CGFloat>, toggle: Binding<Bool>, sliderColor: Color) {
        self.title = title
        self.icon = icon
        self._sliderVal = Binding<Double>(
            get: { Double(sliderVal.wrappedValue) },
            set: { sliderVal.wrappedValue = CGFloat($0) }
        )
        self.sliderRange = Double(sliderRange.lowerBound)...Double(sliderRange.upperBound)
        self._toggle = toggle
        self.sliderColor = sliderColor
    }
}
