//
//  PlayerInfo.swift
//  Yahtzee
//
//  Created by 陳嘉國
//

import Foundation
import SwiftData

@Model
class PlayerData {
    var localUUID: String
    var name: String
    var score: Int
    var timestamp: Date

    init(localUUID: String = UUID().uuidString, name: String = PlayerData.generateRandomName() ) {
        self.localUUID = localUUID
        self.name = name
        self.score = 0
        self.timestamp = Date()
    }
    
    private static func generateRandomName() -> String {
        let randomNumber = Int.random(in: 0...9999)
        return String(format: "Player%04d", randomNumber)
    }

}
