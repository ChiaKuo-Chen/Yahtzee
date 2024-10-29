//
//  RollView.swift
//  Yahtzee

import SwiftUI
import SwiftData

struct DiceRowView: View {

    // MARK: - PROPERTIES
    @Query var gamedata: [GameData]

    // MARK: - BODY

    var body: some View {
        HStack {
            ForEach(0 ..< 5 , id: \.self) { index in
                Image("dice\(gamedata[0].diceArray[index].value)")
                    .resizable()
                    .scaledToFit()
                    .padding(.vertical, 5)
                    .padding(.horizontal, 5)
                    .onTapGesture {
                        if gamedata[0].diceArray[index].value != 0 {
                            gamedata[0].diceArray[index].isHeld.toggle()
                        }
                    }
                    .overlay(
                        Rectangle()
                            .stroke(gamedata[0].diceArray[index].isHeld ? Color.yellow : Color.gray, lineWidth: 2)
                    )
                    .rotationEffect( .degrees(gamedata[0].diceArray[index].isRoll) )
                    .animation(Animation.easeInOut(duration: 1), value: gamedata[0].diceArray[index].isRoll)

                
            }
        } // HSTACK
    }
}

#Preview {
    struct Preview: View {
        
        var body: some View {
            DiceRowView()
                .modelContainer(for: GameData.self)

        }
    }
    return Preview()
}
