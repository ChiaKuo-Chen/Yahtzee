//
//  ScoreBoard.swift
//  Yahtzee
//
import Foundation
import SwiftData

@Model
class ScoreBoard {
    
    var scoresArray : [Int?] = Array(repeating: nil, count: 13) + [0]
    var penTarget : Int? = nil
    var rollCount : Int = 3

    init(scoresArray: [Int?], penTarget: Int?) {
        self.scoresArray = scoresArray
        self.penTarget = penTarget
    }
    
    func updateScoreBoard(newScore: Int, penIndex: Int) {
        scoresArray[penIndex] = newScore
    }

    func returnTotalScore() -> Int {
        
        if self.returnAddUpScore() >= 63 {
            self.scoresArray[13] = 65
        }
        
        var returnValue = 0
        for score in scoresArray {
            if let addScore = score
            {
                returnValue += addScore
            }
        }
        return returnValue
    }

    func returnAddUpScore() -> Int {
        var returnValue = 0
        for i in 0...5 {
            if let addScore = scoresArray[i]
            {
                returnValue += addScore
            }
        }
        return returnValue
    }

    func NewScoreboard() {
        self.scoresArray = Array(repeating: nil, count: 13) + [0]
        self.penTarget = nil
        self.rollCount = 3
    }
    
    private func wetherAlreadyYahtzee() -> Bool {
        return self.scoresArray[11] == 50
    }

}
