//
//  generateInitialData.swift
//  Yahtzee
//

import Foundation

func generateInitialData() -> GameData {
    
    return GameData(currentHighestScore: 0,
                    newHighestScore: 0,
                    soundEffect: true,
                    scoreboard: [ScoreBoard(scoresArray: Array(repeating: nil, count: 13) + [0], penTarget: nil)],
                    diceArray: generateInitialDiceArray()
                    )
    
}

func generateInitialDiceArray() -> [Dice] {
    var retrunValue : [Dice] = []
    for _ in 0..<5 {
        retrunValue.append(Dice(value: 0, isHeld: false, isRoll: 0))
    }
    return retrunValue
}
