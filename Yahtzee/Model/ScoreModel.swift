//  Yahtzee
//

import Foundation

class ScoreModel {
    
    func calculateScore(_ dicerArray: [Dice], category: String, scoreBoard: ScoreBoard) -> Int {
        
        let dicesNumberArray = dicerArray.getDicesNumber()
        let alreadyYathzee: Bool = scoreBoard.wetherAlreadyYahtzee()
        
        let yathzee = Set(dicesNumberArray).count == 1 && !dicesNumberArray.contains(0)

        switch category {

        case "ones" :
            return dicesNumberArray.filter({$0 == 1}).reduce(0, +) + (yathzee&&alreadyYathzee ? 100 : 0)

        case "twos" :
            return dicesNumberArray.filter({$0 == 2}).reduce(0, +) + (yathzee&&alreadyYathzee ? 100 : 0)
            
        case "threes" :
            return dicesNumberArray.filter({$0 == 3}).reduce(0, +) + (yathzee&&alreadyYathzee ? 100 : 0)
            
        case "fours":
            return dicesNumberArray.filter({$0 == 4}).reduce(0, +) + (yathzee&&alreadyYathzee ? 100 : 0)
            
        case "fives" :
            return dicesNumberArray.filter({$0 == 5}).reduce(0, +) + (yathzee&&alreadyYathzee ? 100 : 0)
            
        case "sixes" :
            return dicesNumberArray.filter({$0 == 6}).reduce(0, +) + (yathzee&&alreadyYathzee ? 100 : 0)
            
            
        case "threeOfAKind" :
            for i in 1 ... 6 {
                if dicesNumberArray.filter({$0 == i}).count >= 3 {
                    return dicesNumberArray.reduce(0, +) + (yathzee&&alreadyYathzee ? 100 : 0)
                }
            }
            return 0
            
        case "fourOfAKind" :
            for i in 1 ... 6 {
                if dicesNumberArray.filter({$0 == i}).count >= 4 {
                    return dicesNumberArray.reduce(0, +) + (yathzee&&alreadyYathzee ? 100 : 0)
                }
            }
            return 0
            
        case "fullHouse" :
            for i in 1 ... 6 {
                if dicesNumberArray.filter({$0 == i}).count == 3 {
                    for j in 1 ... 6 {
                        if (dicesNumberArray.filter({$0 == j}).count == 2) && (i != j) {
                            return 25 + (yathzee&&alreadyYathzee ? 100 : 0)
                        }
                    }
                }
            }
            return 0 + (yathzee&&alreadyYathzee ? 100 : 0)
            
        case "smallStraight" :
            if dicesNumberArray.contains(3) && dicesNumberArray.contains(4) {
                if dicesNumberArray.contains(1) && dicesNumberArray.contains(2)
                    || dicesNumberArray.contains(2) && dicesNumberArray.contains(5)
                    || dicesNumberArray.contains(5) && dicesNumberArray.contains(6) {
                    return 30 + (yathzee&&alreadyYathzee ? 100 : 0)
                }
            }
            return 0 + (yathzee&&alreadyYathzee ? 100 : 0)
            
        case "largeStraight" :
            if dicesNumberArray.contains(2) && dicesNumberArray.contains(3) && dicesNumberArray.contains(4) && dicesNumberArray.contains(5){
                if dicesNumberArray.contains(1) || dicesNumberArray.contains(6) {
                    return 40 + (yathzee&&alreadyYathzee ? 100 : 0)
                }
            }
            return 0 + (yathzee&&alreadyYathzee ? 100 : 0)
            
        case "yahtzee" :
            return (yathzee ? 50 : 0)
            // No one could leave score on yahtzee panel twice.

        case "chance" :
            return dicesNumberArray.reduce(0, +) + (yathzee&&alreadyYathzee ? 100 : 0)
            
        default:
            return -1
            
        } // Switch
    }
    
    
    
    
}

