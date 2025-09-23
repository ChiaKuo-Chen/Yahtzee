//
//  Router.swift
//  Yahtzee
//
//  Created by 陳嘉國
//

import Foundation
import SwiftUI

class Router: ObservableObject {
    @Published var path : [Page] = []
}

enum Page: Hashable {
    case gameTable
    case end(finalScore: Int, playerName: String)
    case yahtzee
    case leaderboard(playerName: String, playerID: String, playerScore: Int, playerTimeStamp: String)
}

