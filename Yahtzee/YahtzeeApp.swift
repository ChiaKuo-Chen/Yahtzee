//
//  YahtzeeApp.swift
//  Yahtzee
//

import SwiftUI
import SwiftData
import FirebaseCore


// Prepare for Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct YahtzeeApp: App {
    
    @StateObject private var router = Router()
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate


    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(router)
        }
        .modelContainer(for: [GameData.self, PlayerData.self])
    }
}
