//
//  Persistence.swift
//  Dex
//
//  This file sets up the Core Data persistence layer for the Yahtzee app.
//  It includes the main data container for storing player scores and configurations,
//  as well as a preview version for SwiftUI previews.
//
//  Created by 陳嘉國
//

import CoreData

struct PersistenceController {
    
    // Controller of database
    static let shared = PersistenceController()
    
    // Controller of sample preview database
    @MainActor
    static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
                
        let newPlayer = CorePlayer(context: viewContext)
        newPlayer.localUUID = UUID().uuidString
        newPlayer.score = 135
        newPlayer.name = generateRandomName()
        newPlayer.timestamp = Date()
        
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    // Hold The Database
    let container: NSPersistentContainer
    
    // Init Func
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Yahtzee")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print(error)
            }
        })
        
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    
    private static func generateRandomName() -> String {
        let randomNumber = Int.random(in: 0...9999)
        return String(format: "Player%04d", randomNumber)
    }

}
