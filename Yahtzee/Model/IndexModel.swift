//
//  IndexModel.swift
//  Yahtzee
//

import Foundation

class indexModel {
    
    func returnValue(_ image: String) -> Int {
        
        switch image {
            
        case "redDice1": return 0
        case "redDice2": return 1
        case "redDice3": return 2
        case "redDice4": return 3
        case "redDice5": return 4
        case "redDice6": return 5
        case "red3x": return 6
        case "red4x": return 7
        case "redHouse": return 8
        case "redSmall": return 9
        case "redLarge": return 10
        case "yahtzee": return 11
        case "redChance": return 12
        default: return -1
            
        }
    }
    
    func returnString(_ index: Int) -> String {
        
        switch index {
            
        case 0: return "redDice1"
        case 1: return "redDice2"
        case 2: return "redDice3"
        case 3: return "redDice4"
        case 4: return "redDice5"
        case 5: return "redDice6"
        case 6: return "red3x"
        case 7: return "red4x"
        case 8: return "redHouse"
        case 9: return "redSmall"
        case 10: return "redLarge"
        case 11: return "yahtzee"
        case 12: return "redChance"
        default: return ""
            
        }
    }

}
