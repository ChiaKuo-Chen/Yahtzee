//
//  FetchViewModel.swift
//  Yahtzee
//
//  ViewModel responsible for fetching player data asynchronously.
//  Manages the fetch state and stores fetched player information.
//  Uses a local JSON file for initial data and supports remote fetching.
//
//  Created by 陳嘉國
//

import Foundation

@Observable
@MainActor

// ViewModel that handles fetching player data from a remote source or local file.
// Tracks the fetch status and stores an array of players.
class FetchViewModel {
    
    // Enum representing the current fetch status.
    enum FetchStatus {
        case nonStarted                 // Initial state, no fetch started yet
        case fetching                  // Fetch is in progress
        case successFetch              // Fetch completed successfully
        case failed(error: Error)      // Fetch failed with an error
    }
    
    // The current fetch status, only settable inside this class.
    private(set) var status: FetchStatus = .nonStarted
    
    // The fetcher object responsible for performing the actual fetch operation.
    private let fetcher = FetchModel()
    
    // The list of players fetched from the source.
    var users: [Player]
    
    // MARK: - INITIALIZER
    
    init() {
        // JSON decoder configured for snake_case keys and ISO8601 date format.
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        
        // Load initial user data from local JSON file bundled in the app.
        let usersData = try! Data(contentsOf: Bundle.main.url(forResource: "sampleusers", withExtension: "json")!)
        users = try! decoder.decode([Player].self, from: usersData)
    }
    
    // MARK: - METHODS
    
    // Asynchronously fetches user data from a remote source using `fetcher`.
    // Updates `status` accordingly to reflect progress or errors.
    func getUserData() async {
        status = .fetching
        
        do {
            users = try await fetcher.fetchUsers()
            status = .successFetch
        } catch {
            status = .failed(error: error)
        }
    }
}
