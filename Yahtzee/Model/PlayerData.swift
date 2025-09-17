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

    init(name: String = "Player", id: UUID = UUID()) {
        self.id = id
        self.name = name
    }
}
