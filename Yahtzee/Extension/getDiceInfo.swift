//
//  getDiceNumber.swift
//  Yahtzee
//


import Foundation

extension Array where Element == Dice {
    
    func getDicesNumber() -> [Int] {
        
        var returnArray :[Int] = []
        for item in self {
            returnArray.append(item.value)
        }
        return returnArray
        
    }
    
    func getDicesHeld() -> [Bool] {
        
        var returnArray :[Bool] = []
        for item in self {
            returnArray.append(item.isHeld)
        }
        return returnArray
        
    }

}
