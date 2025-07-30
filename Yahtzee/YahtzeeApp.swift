//
//  YahtzeeApp.swift
//  Yahtzee
//

import SwiftUI
import SwiftData

@main
struct YahtzeeApp: App {
    
    @StateObject private var router = Router()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: GameData.self)
                .environmentObject(router)
        }
    }
}
