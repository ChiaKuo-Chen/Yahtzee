//
//  ShadowButtonModifier.swift
//  Yahtzee
//
//  Created by 陳嘉國
//

import SwiftUI

struct ShadowButtonModifier: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .offset(y: configuration.isPressed ? 8 : 0)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.pink)
                    .offset(y: configuration.isPressed ? 8 : 0)
                    .shadow(color: Color.black, radius: 0,
                            x: 0,
                            y: configuration.isPressed ? 0 : 8)
            )
            .opacity(configuration.isPressed ? 1 : 1)
    }
}
