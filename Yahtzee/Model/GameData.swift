//
//  GameData.swift
//  Yahtzee
//
//  Main game data model using SwiftData to persist game state including sound settings,
//  scoreboard data, and dice information.
//
//  Created by 陳嘉國
//

import Foundation
import SwiftData

// The main game data model representing the current game state,
// including sound effect toggle, scoreboard, and dice values.
@Model
class GameData {
    
    // Indicates whether sound effects are enabled.
    var soundEffect: Bool
    
    // The scoreboard holding the player's scores for different categories.
    var scoreboard: [ScoreBoard]
    
    // Array of dice currently in play.
    var diceArray: [Dice]

    // Initializes a new GameData instance with the given parameters.
    // - Parameters:
    //   - soundEffect: Whether sound effects are enabled.
    //   - scoreboard: Initial scoreboard array.
    //   - diceArray: Initial dice array.
    init(soundEffect: Bool, scoreboard: [ScoreBoard], diceArray: [Dice]) {
        self.soundEffect = soundEffect
        self.scoreboard = scoreboard
        self.diceArray = diceArray
    }
    
    // Resets the dice and scoreboard to initial values,
    // preparing for a new game play session.
    func prepareToNewPlay() {
        self.diceArray = generateInitialDiceArray()
        self.scoreboard = generateInitialScoreBoard()
    }
    
}
