//
//  generateInitialData.swift
//  Yahtzee
//

import Foundation

func generateInitialData() -> GameData {
    return GameData(soundEffect: true,
                    scoreboard: [ScoreBoard()],
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

func generateInitialScoreBoard() -> [ScoreBoard] {
    return [ScoreBoard()]
}

