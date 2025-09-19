//
//  ScoreBoard.swift
//  Yahtzee
//
import Foundation
import SwiftUI
import SwiftData

@Model
class ScoreBoard {
    
    var scoresArray : [Int?] = [Int?](repeating: nil as Int?, count: 13)
    var rollCount: Int = 3

    init() {
    }
    
    func updateScoreBoard(newScore: Int, penIndex: Int) {
        scoresArray[penIndex] = newScore
    }

    func returnTotalScore() -> Int {
            
        var returnValue : Int = ( self.returnAddUpScore() >= 63 ? 35 : 0 )
        
        for score in scoresArray {
            if let addScore = score
            {
                returnValue += addScore
            }
        }
        return returnValue
    }

    func returnAddUpScore() -> Int {
        var returnValue : Int = 0
        for i in 0...5 {
            if let addScore = scoresArray[i]
            {
                returnValue += addScore
            }
        }
        return returnValue
    }
    
    func isNewGame() -> Bool {
        for item in self.scoresArray {
            if item != nil { return false }
        }
        if self.rollCount != 3 { return false }
        
        return true
    }
    
    func wetherAlreadyYahtzee() -> Bool {
        return self.scoresArray[11] == 50
    }

}
