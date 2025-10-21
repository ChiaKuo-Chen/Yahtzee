//
//  DiceRowView.swift
//  Yahtzee
//
//  This view displays a horizontal row of dice used in the Yahtzee game.
//  Each die can be tapped to toggle its "held" state
//  (i.e., whether it should be kept during re-rolls).
//  A border color indicates whether a die is held, and an animation plays during rolling.
//
//  Created by 陳嘉國
//

import SwiftUI
import SwiftData


struct DiceRowView: View {
    
    // MARK: - PROPERTIES
    // Shared game data containing dice states, scoreboard, and settings.
    @Bindable var gameData: GameData
    
    // MARK: - BODY
    var body: some View {
        HStack {
            ForEach(gameData.diceArray) { dice in
                ZStack {
                    // Border to indicate held state (yellow if held, gray otherwise)
                    Rectangle()
                        .stroke(dice.isHeld ? Color.yellow : Color.gray, lineWidth: 2)
                        .scaledToFit()

                    // Dice image based on current value (e.g., dice1, dice2, ...)
                    Image("dice\(dice.value)")
                        .resizable()
                        .scaledToFit()
                        .padding(.vertical, 5)
                        .padding(.horizontal, 5)
                        .onTapGesture {
                            // Tapping toggles the held state (only if the die has a non-zero value)
                            if dice.value != 0 {
                                dice.isHeld.toggle()
                            }
                        }
                        .rotationEffect(.degrees(dice.isRoll)) // Rotates on roll for animation
                        .animation(.easeInOut(duration: 1), value: dice.isRoll)
                }
            }
        }
    }
}
//
import SwiftUI

#Preview {
    struct Preview: View {
        @State var gameData = GameData(
            soundEffect: true,
            scoreboard: [ScoreBoard()],
            diceArray: [
                Dice(value: 1, isHeld: false, isRoll: 0),
                Dice(value: 2, isHeld: false, isRoll: 0),
                Dice(value: 3, isHeld: false, isRoll: 0),
                Dice(value: 4, isHeld: false, isRoll: 0),
                Dice(value: 5, isHeld: false, isRoll: 0)
            ]
        )

        var body: some View {
            DiceRowView(gameData: gameData)
                .frame(height: 100)
                .padding()
        }
    }

    return Preview()
}
