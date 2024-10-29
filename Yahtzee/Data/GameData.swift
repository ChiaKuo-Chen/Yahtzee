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
    
    var scoreboard : [ScoreBoard]
    var diceArray: [Dice]
    
    init(currentHighestScore: Int, newHighestScore: Int, soundEffect: Bool, scoreboard: [ScoreBoard], diceArray: [Dice]) {
        self.currentHighestScore = currentHighestScore
        self.newHighestScore = newHighestScore
        self.soundEffect = soundEffect
        self.scoreboard = scoreboard
        self.diceArray = diceArray
    }
    
    func NewDiceArray() {
        self.diceArray = generateInitialDiceArray()
    }
    
}

