//
//  YahtzeeApp.swift
//  Yahtzee
//

import SwiftUI
import CoreData
import SwiftData
import FirebaseCore

/// AppDelegate class responsible for Firebase initialization
class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Check if GoogleService-Info.plist exists before configuring Firebase
        if let filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"),
           FileManager.default.fileExists(atPath: filePath) {
            FirebaseApp.configure()
            print("✅ Firebase configured.")
        } else {
            print("⚠️ Firebase not configured: GoogleService-Info.plist not found.")
        }
        
        return true
    }
}

@main
struct YahtzeeApp: App {
    
    // Router object used for app-wide navigation
    @StateObject private var router = Router()
    
    // Register AppDelegate to handle Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    // Core Data persistence controller shared instance
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(router) // Inject router into environment
        }
        // SwiftData model container for GameData entity
        .modelContainer(for: GameData.self)
        // Inject Core Data managed object context into environment
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
}
