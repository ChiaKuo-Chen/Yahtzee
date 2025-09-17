//
//  User.swift
//  Yahtzee
//
//  Created by 陳嘉國
//

import Foundation

struct Player: Identifiable, Decodable {
    let id: UUID
    let name: String
    let score: Int
}


