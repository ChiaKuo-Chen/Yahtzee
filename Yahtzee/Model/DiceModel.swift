//
//  Yahtzee
//

import Foundation

struct Dice {
    
    var value: Int = 0
    var isHeld: Bool = false
    var isRoll: Double = 0
    
    mutating func roll() {
        
        if !isHeld {
            self.value = 6//Int.random(in: 1...6)
            self.isRoll += 360
        }
                
    }
    
}

