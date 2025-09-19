//
//  ScaleButtonModifier.swift
//  Yahtzee
//
//  Created by 陳嘉國
//

import SwiftUI

struct ShrinkButtonModifier: ButtonStyle {
    

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .opacity(configuration.isPressed ? 0.8 : 1)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}
