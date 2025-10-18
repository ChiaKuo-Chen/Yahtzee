//
//  AudioSwitchView.swift
//  Yahtzee
//
//  Created by 陳嘉國


import SwiftUI
import SwiftData

struct AudioSwitchView: View {

    // MARK: - PROPERTIES
    @Bindable var gameData: GameData // SwiftData
    @Environment(\.modelContext) private var modelContext // SwiftData

    // MARK: - BODY

    var body: some View {
        
        // It would switch ON/OFF
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
