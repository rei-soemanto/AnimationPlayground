//
//  MorphingPolygon.swift
//  AnimationPlayground
//
//  Created by Rei Soemanto on 16/04/26.
//


import SwiftUI

struct MorphingPolygon: Shape {
    var morphAmount: CGFloat // 0 = Octagon, 1 = Diamond
    
    var animatableData: CGFloat {
        get { morphAmount }
        set { morphAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = min(rect.width, rect.height) / 2
        
        // 8 points for an octagon.
        // For a diamond, the odd points stay at 'radius',
        // the even points pull inwards.
        // cos(45) ≈ 0.707. Pulling radius * 0.707 makes edges straight for a diamond.
        let diamondPullFactor: CGFloat = 0.707
        
        for i in 0..<8 {
            let angle = (CGFloat(i) * (360.0 / 8.0)) * .pi / 180.0
            
            var currentRadius = radius
            if i % 2 != 0 {
                // Morph even corners inward
                let targetRadius = radius * diamondPullFactor
                currentRadius = radius - (radius - targetRadius) * morphAmount
            }
            
            let x = center.x + currentRadius * cos(angle)
            let y = center.y + currentRadius * sin(angle)
            
            if i == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        path.closeSubpath()
        return path
    }
}