//
//  FetchService.swift
//  Yahtzee
//
//  Created by 陳嘉國
//


//https://chiakuo-chen.github.io/yahtzeeLeaderboardApi/data.json

import Foundation

struct FetchService {
    
    private enum FetchError: Error {
        case badResponse
    }
    
    private let baseURL = URL(string: "https://chiakuo-chen.github.io")!
    
    func fetchUsers() async throws -> [Player] {
        
        // Build fetch url
        let fetchURL = baseURL.appending(path: "yahtzeeLeaderboardApi/data.json")
        
        // Fetch data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        // Handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        // Decode data
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let users = try decoder.decode([Player].self, from: data)
        
        // Return
        return users

    }
    

}
