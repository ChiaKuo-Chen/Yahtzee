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
    var id: String
    var name: String

    init(id: String = UUID().uuidString, name: String = PlayerData.generateRandomName() ) {
        self.id = id
        self.name = name
    }
    
    private static func generateRandomName() -> String {
        let randomNumber = Int.random(in: 0...9999)
        return String(format: "Player%04d", randomNumber)
    }

}
