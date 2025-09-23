//
//  User.swift
//  Yahtzee
//
//  Created by 陳嘉國
//

import Foundation
import SwiftUI

struct Player: Identifiable, Codable {
    let id: String
    var name: String
    var score: Int
    var timestamp: String
}


