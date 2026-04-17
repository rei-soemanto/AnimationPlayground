//
//  SectionView.swift
//  AnimationPlayground
//
//  Created by Rei Soemanto on 16/04/26.
//

import SwiftUI

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
        .background(Color.white)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
        .cornerRadius(12)
    }
}
