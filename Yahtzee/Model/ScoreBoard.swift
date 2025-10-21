//
//  ScoreBoard.swift
//  Yahtzee
//
//  This model represents the score board for a Yahtzee game,
//  managing scores for all categories, roll counts, and providing
//  utility functions to update and calculate total scores.
//
//  Created by 陳嘉國
//

import Foundation
import SwiftUI
import SwiftData

@Model
class ScoreBoard {
    
    // Array holding scores for 13 categories. Nil means no score yet.
    var scoresArray : [Int?] = [Int?](repeating: nil as Int?, count: 13)
    
    // Number of dice rolls left in the current turn.
    var rollCount: Int = 3

    // Default initializer.
    init() {
    }
    
    // Update the score for a specific category (index).
    // - Parameters:
    //   - newScore: The score to be assigned.
    //   - penIndex: The index of the score category to update.
    func updateScoreBoard(newScore: Int, penIndex: Int) {
        scoresArray[penIndex] = newScore
    }

    // Calculate the total score including bonus.
    // Bonus of 35 points awarded if upper section scores add up to at least 63.
    // - Returns: The total score as an Int.
    func returnTotalScore() -> Int {
        var returnValue: Int = (self.returnAddUpScore() >= 63 ? 35 : 0)
        
        for score in scoresArray {
            if let addScore = score {
                returnValue += addScore
            }
        }
        return returnValue
    }

    // Calculate the total score from the upper section (first 6 categories).
    // - Returns: The upper section total score.
    func returnAddUpScore() -> Int {
        var returnValue: Int = 0
        for i in 0...5 {
            if let addScore = scoresArray[i] {
                returnValue += addScore
            }
        }
        return returnValue
    }
    
    // Check whether the current scoreboard represents a new game.
    // A new game has no scores and rollCount reset to 3.
    // - Returns: True if it's a new game, false otherwise.
    func isNewGame() -> Bool {
        for item in self.scoresArray {
            if item != nil { return false }
        }
        if self.rollCount != 3 { return false }
        return true
    }
    
    // Check if a Yahtzee (50 points) has already been scored.
    // - Returns: True if Yahtzee was scored, false otherwise.
    func wetherAlreadyYahtzee() -> Bool {
        return self.scoresArray[11] == 50
    }

}
