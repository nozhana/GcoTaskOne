//
//  AnimatablePositionModifier.swift
//  GcoTaskOne
//
//  Created by Nozhan Amiri on 10/1/24.
//

import SwiftUI

struct AnimatablePositionModifier: Animatable, ViewModifier {
    let path: Path
    var start: CGPoint = .zero
    var progress: Double = 0
    
    var animatableData: Double {
        get { progress }
        set { progress = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .position(path.trimmedPath(from: 0, to: progress).currentPoint ?? start)
    }
}


extension View {
    func animatePosition(alongPath path: Path, start: CGPoint = .zero, progress: Double) -> some View {
        modifier(AnimatablePositionModifier(path: path, start: start, progress: progress))
    }
}
