//
//  YahtzeeApp.swift
//  Yahtzee
//

import SwiftUI
import SwiftData

@main
struct YahtzeeApp: App {
    var body: some Scene {
        WindowGroup {
            CoverView()
                .environmentObject(ScoreBoard())
                .modelContainer(for: GameSettingsData.self)
        }
    }
}
