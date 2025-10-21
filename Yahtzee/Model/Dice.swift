//
//  Dice.swift
//  Yahtzee
//
//  This model represents a single dice used in the Yahtzee game.
//  It manages the dice's current face value, hold state (whether
//  the dice is kept from rolling), and an animation state to track
//  rotation degrees when rolling.
//
//  Created by 陳嘉國
//

import Foundation
import SwiftData

@Model
class Dice {
    
    // Current face value of the dice (1-6). Default is 0 meaning not rolled yet.
    var value: Int = 0
    
    // Whether the dice is held (kept) by the player and should not roll.
    var isHeld: Bool = false
    
    // Rotation state for dice rolling animation, expressed in degrees.
    // Incremented by 360 on each roll for animation effect.
    var isRoll: Double = 0
    
    // Designated initializer.
    // - Parameters:
    //   - value: Initial dice face value.
    //   - isHeld: Initial hold status.
    //   - isRoll: Initial rotation animation state.
    init(value: Int, isHeld: Bool, isRoll: Double) {
        self.value = value
        self.isHeld = isHeld
        self.isRoll = isRoll
    }
    
    // Roll the dice if it is not held.
    // Assigns a new random value between 1 and 6.
    // Increments rotation state for animation.
    func roll() {
        if !isHeld {
            self.value = Int.random(in: 1...6)
            self.isRoll += 360
        }
    }
    
}
