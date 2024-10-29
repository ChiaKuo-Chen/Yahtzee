//
//  Yahtzee
//

import Foundation
import SwiftData

@Model
class Dice {
    
    var value: Int = 0
    var isHeld: Bool = false
    var isRoll: Double = 0
    
    init(value: Int, isHeld: Bool, isRoll: Double) {
        self.value = value
        self.isHeld = isHeld
        self.isRoll = isRoll
    }
    
    func roll() {
        
        if !isHeld {
            self.value = Int.random(in: 1...6)
            self.isRoll += 360
        }
                
    }
    
}

