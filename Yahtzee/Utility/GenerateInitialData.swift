//
//  generateInitialData.swift
//  Yahtzee
//

import Foundation

func generateInitialData() -> GameData {
    
    return GameData(currentHighestScore: 0,
                    newHighestScore: 0,
                    soundEffect: true,
                    scoreboard: [ScoreBoard(scoresArray: Array(repeating: nil, count: 13) + [0], penTarget: nil)]
                    )
    
}
