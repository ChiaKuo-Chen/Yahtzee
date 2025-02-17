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
            ContentView()
                .modelContainer(for: GameData.self)
        }
    }
}
