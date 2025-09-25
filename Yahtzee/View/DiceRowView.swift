//
//  RollView.swift
//  Yahtzee

import SwiftUI
import SwiftData

struct DiceRowView: View {
    
    // MARK: - PROPERTIES
    @Bindable var gameData: GameData
    
    // MARK: - BODY
    var body: some View {
        HStack {
            ForEach(gameData.diceArray) { dice in
                ZStack {
                    Rectangle()
                        .stroke(dice.isHeld ? Color.yellow : Color.gray, lineWidth: 2)
                        .scaledToFit()

                    Image("dice\(dice.value)")
                        .resizable()
                        .scaledToFit()
                        .padding(.vertical, 5)
                        .padding(.horizontal, 5)
                        .onTapGesture {
                            if dice.value != 0 {
                                dice.isHeld.toggle()
                            }
                        }
                        .rotationEffect(.degrees(dice.isRoll))
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
