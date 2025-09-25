//
//  User.swift
//  Yahtzee
//
//  Created by 陳嘉國
//

import Foundation
import SwiftUI

struct Player: Identifiable, Codable {
    let localUUID: String
    var name: String
    var score: Int
    var timestamp: Date
    
    var id: String { localUUID }
}


