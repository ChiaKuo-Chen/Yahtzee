//
//  scoreBoard.swift
//  Yahtzee
//

import Foundation

class ScoreBoard: ObservableObject {
    
    @Published var scoresArray : [Int?] = Array(repeating: nil, count: 13) + [0]
    @Published var targetArray : [Bool] = Array(repeating: false, count: 13)
    
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

    func wetherAlreadyYahtzee() -> Bool {
        return self.scoresArray[11] == 50
    }

}

