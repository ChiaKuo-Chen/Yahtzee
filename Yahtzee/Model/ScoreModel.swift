//  Yahtzee
//

import Foundation

class ScoreModel {
    
    func caculateScore(_ dicerArray: [Dice], index: Int) -> Int {
        
        let dicesNumberArray = dicerArray.getDicesNumber()
        
        switch index {

        case 0:
            return dicesNumberArray.filter({$0 == 1}).reduce(0, +)
            
        case 1:
            return dicesNumberArray.filter({$0 == 2}).reduce(0, +)
            
        case 2:
            return dicesNumberArray.filter({$0 == 3}).reduce(0, +)
            
        case 3:
            return dicesNumberArray.filter({$0 == 4}).reduce(0, +)
            
        case 4:
            return dicesNumberArray.filter({$0 == 5}).reduce(0, +)
            
        case 5:
            return dicesNumberArray.filter({$0 == 6}).reduce(0, +)
            
            
        case 6:
            for i in 1 ... 6 {
                if dicesNumberArray.filter({$0 == i}).count >= 3 {
                    return dicesNumberArray.reduce(0, +)
                }
            }
            return 0
            
        case 7:
            for i in 1 ... 6 {
                if dicesNumberArray.filter({$0 == i}).count >= 4 {
                    return dicesNumberArray.reduce(0, +)
                }
            }
            return 0
            
        case 8:
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
            
        case 9:
            if dicesNumberArray.contains(3) && dicesNumberArray.contains(4) {
                if dicesNumberArray.contains(1) && dicesNumberArray.contains(2)
                    || dicesNumberArray.contains(2) && dicesNumberArray.contains(5)
                    || dicesNumberArray.contains(5) && dicesNumberArray.contains(6) {
                    return 30
                }
            }
            return 0
            
        case 10:
            if dicesNumberArray.contains(2) && dicesNumberArray.contains(3) && dicesNumberArray.contains(4) && dicesNumberArray.contains(5){
                if dicesNumberArray.contains(1) || dicesNumberArray.contains(6) {
                    return 40
                }
            }
            return 0
            
        case 11:
            for i in 1 ... 6 {
                if dicesNumberArray.filter({$0 == i}).count == 5 {
                    return 50
                }
            }
            return 0

        case 12:
            return dicesNumberArray.reduce(0, +)
            
        default:
            return -1
            
        }
    }
    
    
    
    
}

