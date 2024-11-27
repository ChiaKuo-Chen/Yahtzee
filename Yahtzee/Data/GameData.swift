//
//  SoundEffect.swift
//  Yahtzee
//
import Foundation
import SwiftData

@Model
class GameData {
    
    var currentHighestScore: Int
    var soundEffect: Bool
    
    var scoreboard : [ScoreBoard]
    var diceArray: [Dice]
    
    init(currentHighestScore: Int, soundEffect: Bool, scoreboard: [ScoreBoard], diceArray: [Dice]) {
        self.currentHighestScore = currentHighestScore
        self.soundEffect = soundEffect
        self.scoreboard = scoreboard
        self.diceArray = diceArray
    }
    
    func prepareToNewPlay() {
        self.diceArray = generateInitialDiceArray()
        self.scoreboard = generateInitialScoreBoard()
    }
    
}

