import SwiftUI

struct EffectControlView: View {
    let title: String
    let icon: String
    @Binding var sliderVal: Double
    let sliderRange: ClosedRange<Double>
    @Binding var toggle: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Label(title, systemImage: icon).font(.headline)
                Spacer()
                Toggle("", isOn: $toggle).labelsHidden()
            }
            Slider(value: $sliderVal, in: sliderRange)
                .accentColor(.purple)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

// Extension to handle the CGFloat version seamlessly
extension EffectControlView {
    init(title: String, icon: String, sliderVal: Binding<CGFloat>, sliderRange: ClosedRange<CGFloat>, toggle: Binding<Bool>) {
        self.title = title
        self.icon = icon
        // Convert CGFloat binding to Double binding automatically
        self._sliderVal = Binding<Double>(
            get: { Double(sliderVal.wrappedValue) },
            set: { sliderVal.wrappedValue = CGFloat($0) }
        )
        self.sliderRange = Double(sliderRange.lowerBound)...Double(sliderRange.upperBound)
        self._toggle = toggle
    }
}