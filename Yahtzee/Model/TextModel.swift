//
//  TextModel.swift
//  Yahtzee
//

import Foundation

class textModel {

    func returnString(_ image: String) -> String {
        
        switch image {
            
        case "redDice1": return "Ones"
        case "redDice2": return "Twos"
        case "redDice3": return "Threes"
        case "redDice4": return "Fours"
        case "redDice5": return "Fives"
        case "redDice6": return "Sixes"
        case "red3x": return "Three of a kind"
        case "red4x": return "Four of a kind"
        case "redHouse": return "Full House"
        case "redSmall": return "Small Straight"
        case "redLarge": return "Large Straight"
        case "yahtzee": return "Yahtzee"
        case "redChance": return "Chance"
        default: return ""
            
        }
        
    }
}
