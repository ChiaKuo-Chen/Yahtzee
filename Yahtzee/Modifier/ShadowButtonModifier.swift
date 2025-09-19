//
//  ShadowButtonModifier.swift
//  Yahtzee
//
//  Created by 陳嘉國
//

import SwiftUI

struct ShadowButtonModifier: ButtonStyle {
    
    private let lightingColor = [Color.white.opacity(0.4), Color.clear,
                                 Color.clear, Color.clear]

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .offset(y: configuration.isPressed ? 8 : 0)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color.pink)
                    .offset(y: configuration.isPressed ? 8 : 0)
                    .shadow(color: Color.black, radius: 0,
                            x: configuration.isPressed ? 0 : 1,
                            y: configuration.isPressed ? 0 : 4)
                    .shadow(color: Color.black, radius: 0,
                            x: configuration.isPressed ? 0 : -1,
                            y: configuration.isPressed ? 0 : 4)
            )
            .opacity(configuration.isPressed ? 1 : 1)
            .overlay{
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(
                        LinearGradient(colors: lightingColor, startPoint: .top, endPoint: .bottom)
                    )
                    .offset(y: configuration.isPressed ? 8 : 0)
            }

    }
}
