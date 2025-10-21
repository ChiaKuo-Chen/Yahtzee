//
//  FetchModel.swift
//  Yahtzee
//
//  Responsible for fetching player leaderboard data from a remote API endpoint asynchronously.
//  Handles network requests, response validation, and JSON decoding into Player model objects.
//
//  Created by 陳嘉國
//
//  API Endpoint:
//  https://chiakuo-chen.github.io/yahtzeeLeaderboardApi/data.json

import Foundation

struct FetchModel {
    // Enum representing possible errors during fetching.
    private enum FetchError: Error {
        case badResponse
    }
    // Base URL for the API.
    private let baseURL = URL(string: "https://chiakuo-chen.github.io")!
    
    // Fetches users asynchronously from the leaderboard API.
    // - Throws: An error if the network request fails or the data cannot be decoded.
    // - Returns: An array of Player objects decoded from the JSON response.
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
        decoder.dateDecodingStrategy = .iso8601
        let users = try decoder.decode([Player].self, from: data)
        
        // Return
        return users

    }
    

}
