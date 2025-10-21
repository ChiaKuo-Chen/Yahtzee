//
//  generateInitialData.swift
//  Yahtzee
//
//  Provides helper functions to generate initial game data for starting a new game,
//  including game settings, dice array, and scoreboard initialization.
//
//  Created by 陳嘉國
//

import Foundation

// Generates the initial `GameData` instance with default settings.
// - Returns: A new `GameData` object with sound effects enabled,
//            a fresh scoreboard, and a set of initial dice.
func generateInitialData() -> GameData {
    return GameData(soundEffect: true,
                    scoreboard: [ScoreBoard()],
                    diceArray: generateInitialDiceArray()
                    )
}

// Creates an initial array of 5 dice, each with default values.
// - Returns: An array of 5 `Dice` objects, all unrolled and not held.
func generateInitialDiceArray() -> [Dice] {
    var returnValue : [Dice] = []
    for _ in 0..<5 {
        returnValue.append(Dice(value: 0, isHeld: false, isRoll: 0))
    }
    return returnValue
}

// Generates a new scoreboard array with a single empty `ScoreBoard`.
// - Returns: An array containing one `ScoreBoard` instance.
func generateInitialScoreBoard() -> [ScoreBoard] {
    return [ScoreBoard()]
}

