//
//  Router.swift
//  Yahtzee
//
//  Router class manages the navigation stack (path) for the app.
//  Used with NavigationStack to control which pages are currently displayed.
//
//  Created by 陳嘉國
//

import Foundation
import SwiftUI

// ObservableObject that manages navigation paths for the app.
// Controls the current view stack via a published `path` array of `Page` enums.
class Router: ObservableObject {
    // The navigation path stack, holding the current pages in the navigation hierarchy.
    @Published var path: [Page] = []
}

// Enumeration representing all possible pages/screens in the app.
// Used for navigation routing and passing data between views.
enum Page: Hashable {
    case gameTable
    case end(finalScore: Int)  // End page with the final score
    case yahtzee              // Special animation page for Yahtzee event
    case leaderboard(playerName: String, playerID: String, playerScore: Int, playerTimeStamp: Date) // Leaderboard page with player info
}
