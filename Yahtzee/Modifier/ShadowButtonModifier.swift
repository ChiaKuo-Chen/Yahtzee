//
//  ShadowButtonModifier.swift
//  Yahtzee
//
//  A custom button style that simulates a pressed shadow effect
//  using layered rounded rectangles and offsets.
//
//  Created by 陳嘉國
//

import SwiftUI

// A custom `ButtonStyle` that gives the appearance of a button being pressed
// by changing its offset and adding layered shadows.
struct ShadowButtonModifier: ButtonStyle {
    
    // A vertical gradient overlay simulating lighting on the button.
    private let lightingColor = [
        Color.white.opacity(0.4),
        Color.clear,
        Color.clear,
        Color.clear
    ]

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            // Moves the button down when pressed
            .offset(y: configuration.isPressed ? 8 : 0)
            .background(
                // Pink rounded rectangle as the button base
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color.pink)
                    .offset(y: configuration.isPressed ? 8 : 0)
                    .shadow(
                        color: Color.black,
                        radius: 0,
                        x: configuration.isPressed ? 0 : 1,
                        y: configuration.isPressed ? 0 : 4
                    )
                    .shadow(
                        color: Color.black,
                        radius: 0,
                        x: configuration.isPressed ? 0 : -1,
                        y: configuration.isPressed ? 0 : 4
                    )
            )
            // Ensures consistent opacity
            .opacity(configuration.isPressed ? 1 : 1)
            // Lighting gradient overlay to simulate top light
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(
                        LinearGradient(
                            colors: lightingColor,
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .offset(y: configuration.isPressed ? 8 : 0)
            }
    }
}
