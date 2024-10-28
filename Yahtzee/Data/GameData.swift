//
//  SoundEffect.swift
//  Yahtzee
//
import Foundation
import SwiftData

@Model
class GameData {
    
    var currentHighestScore: Int
    var newHighestScore: Int
    var soundEffect: Bool
    var scoresArray : [Int?] = ( Array(repeating: nil, count: 13) + [0] )
    var penTarget : Int? = nil // ScoreArray or Nil

    init(currentHighestScore: Int, newHighestScore: Int, soundEffect: Bool, scoresArray: [Int?], penTarget: Int? = nil) {
        self.currentHighestScore = currentHighestScore
        self.newHighestScore = newHighestScore
        self.soundEffect = soundEffect
        self.scoresArray = scoresArray
        self.penTarget = penTarget
    }
    
    func updateScoreBoard(newScore: Int) {
        
        if let penIndex = penTarget {
            scoresArray[penIndex] = newScore
        }
        
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

    private func wetherAlreadyYahtzee() -> Bool {
        return self.scoresArray[11] == 50
    }


}
