//
//  ExShadowFrame.swift
//  Yahtzee
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
