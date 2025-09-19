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
    var id: UUID
    var name: String

    init(name: String = "Player\(String(format: "%04d", Int.random(in: 0...9999)))", id: UUID = UUID()) {
        self.id = id
        self.name = name
    }
}
