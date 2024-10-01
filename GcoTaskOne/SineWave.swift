//
//  SineWave.swift
//  GcoTaskOne
//
//  Created by Nozhan Amiri on 9/30/24.
//

import SwiftUI

struct SineWave: Shape {
    var amplitude: Double = 1
    var frequency: Double = 1
    var phase: Double = 0
    var taperLeading: Double = 0
    var taperTrailing: Double = 0
    
    var animatableData: AnimatablePair<Double, AnimatablePair<Double, Double>> {
        get { AnimatablePair(phase, AnimatablePair(taperLeading, taperTrailing)) }
        set {
            self.phase = newValue.first
            self.taperLeading = newValue.second.first
            self.taperTrailing = newValue.second.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath()
        
        let width = Double(rect.width)
        let height = Double(rect.height)
        
        let midHeight = height / 2
        
        let wavelength = width / frequency / .pi / 2
        
        let leading = taperLeading * width
        let trailing = taperTrailing * width
        
        for x in stride(from: leading, through: width - trailing, by: 1) {
            let relativeX = x / wavelength
            let sine = sin(relativeX + phase)
            let y = sine * midHeight * amplitude + midHeight
            
            if x <= leading {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        return Path(path.cgPath)
    }
}
