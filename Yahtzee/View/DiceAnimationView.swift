//
//  DiceAnimationView.swift
//  Yahtzee
//
//  A simple animation of a big red dice that gently swings left and right repeatedly.
//
//  Created by 陳嘉國
//

import SwiftUI

struct DiceAnimationView: View {

    // MARK: - PROPERTIES
    @State private var pulsateAnimation: Bool = false 

    // MARK: - BODY

    var body: some View {
        
        // Big Red Dice swinging back and forth
        ZStack {
            Image("bigRedDice")
                .resizable()
                .scaledToFit()
                .rotationEffect(.degrees(pulsateAnimation ? -10 : 10))
                .animation(.easeInOut(duration: 3).repeatForever(), value: pulsateAnimation)
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.pulsateAnimation = true
            }
        }
        
    }
}

#Preview {
    DiceAnimationView()
}
