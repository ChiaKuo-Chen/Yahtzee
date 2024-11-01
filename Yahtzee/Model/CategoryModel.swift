//
//  IndexModel.swift
//  Yahtzee
//

import Foundation

class CategoryModel {
    
    func returnIndex(_ category: String) -> Int {
        
        switch category {
            
        case "ones" : return 0
        case "twos" : return 1
        case "threes" : return 2
        case "fours" : return 3
        case "fives" : return 4
        case "sixes" : return 5
        case "threeOfAKind" : return 6
        case "fourOfAKind" : return 7
        case "fullHouse" : return 8
        case "smallStraight" : return 9
        case "largeStraight" : return 10
        case "yahtzee": return 11
        case "chance": return 12
        default: return -1

        }
    }
    
    
    func returnPicString(_ category: String) -> String {
        
        switch category {
            
        case "ones" : return "redDice1"
        case "twos" : return "redDice2"
        case "threes" : return "redDice3"
        case "fours" : return "redDice4"
        case "fives" : return "redDice5"
        case "sixes" : return "redDice6"
        case "threeOfAKind" : return "red3x"
        case "fourOfAKind" : return "red4x"
        case "fullHouse" : return "redHouse"
        case "smallStraight" : return "redSmall"
        case "largeStraight" : return "redLarge"
        case "yahtzee": return "yahtzee"
        case "chance": return "redChance"
        default: return ""

        }
        
    }


    func returnRuleString(_ category: String) -> String {
        
        switch category {
            
        case "ones" : return "Ones"
        case "twos" : return "Twos"
        case "threes" : return "Threes"
        case "fours" : return "Fours"
        case "fives" : return "Fives"
        case "sixes" : return "Sixes"
        case "threeOfAKind" : return "Three of \n  a kind"
        case "fourOfAKind" : return "Four of \n  a kind"
        case "fullHouse" : return "Full \n House"
        case "smallStraight" : return "Small \n Straight"
        case "largeStraight" : return "Large \n Straight"
        case "yahtzee": return "Yahtzee"
        case "chance": return "Chance"
        default: return ""

        }
        
    }


}
