//
//  AudioSwitchView.swift
//  Yahtzee
//
//  A modal view that allows the player to change their display name.
//  Updates local CoreData storage and syncs with Firebase if configured.
//
//  Created by 陳嘉國
//

import SwiftUI
import SwiftData

struct AudioSwitchView: View {

    // MARK: - PROPERTIES
    @Bindable var gameData: GameData // SwiftData-bound game data for sound effect toggle
    @Environment(\.modelContext) private var modelContext // SwiftData context for saving changes

    // MARK: - BODY

    var body: some View {
        
        // Speaker icon that toggles sound effect on tap
        Image(systemName: gameData.soundEffect != false ? "speaker.wave.2.circle" : "speaker.slash.circle")
            .font(.system(size: 40))
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
