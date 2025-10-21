//
//  ExShadowFrame.swift
//  Yahtzee
//
//  This file defines a View extension that applies a four-directional shadow
//  effect around a view, giving it a framed or "glow" appearance.
//
//  Created by 陳嘉國
//

import SwiftUI

extension View {
    
    func shadowFrame(color: Color = .black, radius: CGFloat = 0, frameSize: CGFloat) -> some View {
        self
            .shadow(color: color, radius: radius, x: frameSize, y: frameSize)
            .shadow(color: color, radius: radius, x: frameSize, y: -frameSize)
            .shadow(color: color, radius: radius, x: -frameSize, y: frameSize)
            .shadow(color: color, radius: radius, x: -frameSize, y: -frameSize)
    }
}
