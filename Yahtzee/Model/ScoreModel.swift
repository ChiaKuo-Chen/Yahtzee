//  Yahtzee
//

import Foundation

class scoreModel {
    
    func caculateScore(_ dicesNumberArray: [Int],_ image: String) -> Int {
        
        
        switch image {
            
        case "redDice1":
            return dicesNumberArray.filter({$0 == 1}).reduce(0, +)
            
            
        case "redDice2":
            return dicesNumberArray.filter({$0 == 2}).reduce(0, +)
            
        case "redDice3":
            return dicesNumberArray.filter({$0 == 3}).reduce(0, +)
            
        case "redDice4":
            return dicesNumberArray.filter({$0 == 4}).reduce(0, +)
            
        case "redDice5":
            return dicesNumberArray.filter({$0 == 5}).reduce(0, +)
            
        case "redDice6":
            return dicesNumberArray.filter({$0 == 6}).reduce(0, +)
            
            
        case "red3x":
            for i in 1 ... 6 {
                if dicesNumberArray.filter({$0 == i}).count >= 3 {
                    return dicesNumberArray.reduce(0, +)
                }
            }
            return 0
            
        case "red4x":
            for i in 1 ... 6 {
                if dicesNumberArray.filter({$0 == i}).count >= 4 {
                    return dicesNumberArray.reduce(0, +)
                }
            }
            return 0
            
        case "redHouse":
            for i in 1 ... 6 {
                if dicesNumberArray.filter({$0 == i}).count == 3 {
                    for j in 1 ... 6 {
                        if (dicesNumberArray.filter({$0 == j}).count == 2) && (i != j) {
                            return 25
                        }
                    }
                }
            }
            return 0
            
        case "redSmall":
            if dicesNumberArray.contains(3) && dicesNumberArray.contains(4) {
                if dicesNumberArray.contains(1) && dicesNumberArray.contains(2)
                    || dicesNumberArray.contains(2) && dicesNumberArray.contains(5)
                    || dicesNumberArray.contains(5) && dicesNumberArray.contains(6) {
                    return 30
                }
            }
            return 0
            
        case "redLarge":
            if dicesNumberArray.contains(2) && dicesNumberArray.contains(3) && dicesNumberArray.contains(4) && dicesNumberArray.contains(5){
                if dicesNumberArray.contains(1) || dicesNumberArray.contains(6) {
                    return 40
                }
            }
            return 0
            
        case "yahtzee":
            for i in 1 ... 6 {
                if dicesNumberArray.filter({$0 == i}).count == 5 {
                    return 50
                }
            }
            return 0

        case "redChance":
            return dicesNumberArray.reduce(0, +)
            
        default:
            return -1
            
        }
    }
    
    
    
    
}

