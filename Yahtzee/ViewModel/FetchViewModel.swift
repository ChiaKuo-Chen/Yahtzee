//
//  FetchViewModel.swift
//  Yahtzee
//
//  Created by 陳嘉國
//

import Foundation

@Observable
@MainActor

class FetchViewModel {
    enum FetchStatus {
        case notStatred
        case fetching
        case successFetch
        case failed(error: Error)
    }
    
    private(set) var status: FetchStatus = .notStatred
    
    private let fetcher = FetchService()
    
    var users: [Player]
    
    init() {
//        users = []
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let usersData = try! Data(contentsOf: Bundle.main.url(forResource: "sampleusers", withExtension: "json")!)
        users = try! decoder.decode([Player].self, from: usersData)
    }
    
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
