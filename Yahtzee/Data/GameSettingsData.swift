//
//  SoundEffect.swift
//  Yahtzee
//
import Foundation
import SwiftData

@Model
class GameSettingsData {
    
    var currentHighestScore: Int
    var newHighestScore: Int
    var soundEffect: Bool
    
    init(currentHighestScore: Int, newHighestScore: Int, soundEffect: Bool) {
        self.currentHighestScore = currentHighestScore
        self.newHighestScore = newHighestScore
        self.soundEffect = soundEffect
    }
        
}
