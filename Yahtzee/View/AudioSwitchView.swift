//
//  AudioSwitchView.swift
//  Yahtzee
//
//  This view displays the switch button
//  Allows the player to open/close their sound effect.
//  Updates swiftData storage.
//
//  Created by 陳嘉國
//

import SwiftUI
import SwiftData

struct AudioSwitchView: View {

    // MARK: - PROPERTIES
    // The main game data model containing dice, scores, and game state
    @Bindable var gameData: GameData // SwiftData bound model
    
    // SwiftData model context (used for saving / inserting new game data)
    @Environment(\.modelContext) private var modelContext

    var fontSize: CGFloat = 40

    // MARK: - BODY

    var body: some View {
        

        // Speaker icon that toggles sound effect on tap
        Image(systemName: gameData.soundEffect != false ? "speaker.wave.2.circle" : "speaker.slash.circle")
            .font(.system(size: fontSize))
            .onTapGesture {
                gameData.soundEffect.toggle()
                try? modelContext.save()
            }
    }

                        
}

#Preview("HeaderView Preview") {
    let container = try! ModelContainer(for: GameData.self, ScoreBoard.self, Dice.self)
    let previewGameData = generateInitialData()

    AudioSwitchView(gameData: previewGameData)
        .foregroundStyle(Color.black)
        .scaleEffect(3)
        .modelContainer(container)
}
