//
//  YahtzeeApp.swift
//  Yahtzee
//

import SwiftUI
import CoreData
import SwiftData
import FirebaseCore

// Prepare for Firebase
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      
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
    
    @StateObject private var router = Router()
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(router)
        }
        .modelContainer(for: [GameData.self, PlayerData.self])
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
}
