//
//  IndexModel.swift
//  Yahtzee
//

import Foundation


class CategoryModel {
    
    private let categoryArray : [String] = ["ones", "twos", "threes", "fours", "fives", "sixes",
                                   "threeOfAKind", "fourOfAKind", "fullHouse", "smallStraight", "largeStraight", "yahtzee", "chance"]
    
    private let pictureDictionary : [String: String] = [ "ones" :"redDice1", "twos" :"redDice2", "threes" :"redDice3",
                                                         "fours" :"redDice4", "fives" :"redDice5", "sixes" :"redDice6",
                                                         "threeOfAKind" :"red3x", "fourOfAKind" :"red4x", "fullHouse" :"redHouse",
                                                         "smallStraight" :"redSmall", "largeStraight" :"redLarge", "yahtzee":"yahtzee",
                                                         "chance":"redChance" ]
    
    private let ruleDictionary : [String: String] = [ "ones" : "Ones", "twos" :"Twos", "threes" :"Threes", "fours" :"Fours",
                                                      "fives" :"Fives", "sixes" :"Sixes", "threeOfAKind" : "Three of \n  a kind",
                                                      "fourOfAKind" : "Four of \n  a kind", "fullHouse" : "Full \n House",
                                                      "smallStraight" : "Small \n Straight", "largeStraight" : "Large \n Straight",
                                                      "yahtzee" : "Yahtzee", "chance" : "Chance" ]

    func returnCategory(_ index: Int) -> String {
        guard index >= 0 && index < 13 else { return "" }
        return categoryArray[index]
    }
    

    func returnIndex(_ category: String) -> Int {
        
        for (index, item) in categoryArray.enumerated() {
            if item == category {
                return index
            }
        }
        
        return -1
        
    }
    
    
    func returnPicString(_ category: String) -> String {
        
        if let returnValue = pictureDictionary[category] {
            return returnValue
        }
        
        return ""
        
    }


    func returnRuleString(_ category: String) -> String {
        
        if let returnValue = ruleDictionary[category] {
            return returnValue
        }
        
        return ""

    }


}
