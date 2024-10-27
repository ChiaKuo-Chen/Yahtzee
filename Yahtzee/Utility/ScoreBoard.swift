//
//  scoreBoard.swift
//  Yahtzee
//

import Foundation

class ScoreBoard: ObservableObject {
    
    @Published var scoresArray : [Int?] = Array(repeating: nil, count: 13) + [0]
    @Published var penTarget : Int? = nil // ScoreArray or Nil
    let scoremodel = ScoreModel()
    
    func updateScoreBoard(diceArray: [Dice]) {
        
        if let penIndex = penTarget {
            scoresArray[penIndex] = scoremodel.caculateScore(diceArray, index: penIndex)
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

