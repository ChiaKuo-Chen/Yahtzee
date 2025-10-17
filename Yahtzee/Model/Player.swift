//
//  User.swift
//  Yahtzee
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


