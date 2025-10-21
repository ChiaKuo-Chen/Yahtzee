//
//  getDiceInfo.swift
//  Yahtzee
//
//
//  This file adds extensions to arrays of `Dice` elements, providing utility
//  methods to extract dice values and held statuses.
//
//  Created by 陳嘉國
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
