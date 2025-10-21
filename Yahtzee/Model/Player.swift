//
//  Player.swift
//  Yahtzee
//
//  Defines the Player model used to represent user data for the Yahtzee leaderboard.
//  This includes identifying information, player score, and timestamp.
//  Supports decoding from both local JSON files and Firebase Firestore data.
//
//  Created by 陳嘉國
//

import Foundation
import SwiftUI
import FirebaseCore

struct Player: Identifiable, Codable {
    let localUUID: String
    var name: String
    var score: Int
    var timestamp: Date
    
    var id: String { localUUID }
    
    
    // Creates a Player instance from a Firebase Firestore dictionary.
    // - Parameter data: Dictionary retrieved from Firestore representing a player.
    // - Returns: A `Player` instance with properly parsed values.
    static func from(data: [String: Any]) -> Player {
        let timestamp: Date
        if let ts = data["timestamp"] as? Timestamp {
            timestamp = ts.dateValue()
        } else {
            timestamp = Date()
        }

        return Player(
            localUUID: data["localUUID"] as? String ?? "00000000-0000-0000-0000-000000000000",
            name: data["name"] as? String ?? "Unknown",
            score: data["score"] as? Int ?? 0,
            timestamp: timestamp
        )
    }

}


