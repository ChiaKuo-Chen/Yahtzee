//
//  ScoreModel.swift
//  Yahtzee
//
//  Handles the score calculation logic for various Yahtzee categories
//  based on the current dice values and game state.
//
//  Created by 陳嘉國
//

import Foundation

class ScoreModel {
    
    // Calculates the score for a given category based on the dice array and scoreboard status.
    // - Parameters:
    //   - dicerArray: The current array of dice objects.
    //   - category: The scoring category (e.g., "ones", "fullHouse", "yahtzee").
    //   - scoreBoard: The current scoreboard, used to check game state (like if Yahtzee was already scored).
    // - Returns: The score for the specified category.
    
    func calculateScore(_ dicerArray: [Dice], category: String, scoreBoard: ScoreBoard) -> Int {
        
        // Extract dice values into an array of Ints (1-6), ignoring dice with value 0
        let dicesNumberArray = dicerArray.getDicesNumber()
        
        // Check if player has already scored a Yahtzee (50 points in category 11)
        let alreadyYathzee: Bool = scoreBoard.wetherAlreadyYahtzee()
        
        // Determine if current dice are a Yahtzee (all dice have the same non-zero value)
        let yathzee = Set(dicesNumberArray).count == 1 && !dicesNumberArray.contains(0)

        switch category {

        // For categories ones through sixes, sum the dice with matching values
        // If current dice is a Yahtzee and player already has one, add 100 bonus points
        case "ones" :
            return dicesNumberArray.filter({$0 == 1}).reduce(0, +) + (yathzee && alreadyYathzee ? 100 : 0)

        case "twos" :
            return dicesNumberArray.filter({$0 == 2}).reduce(0, +) + (yathzee && alreadyYathzee ? 100 : 0)
            
        case "threes" :
            return dicesNumberArray.filter({$0 == 3}).reduce(0, +) + (yathzee && alreadyYathzee ? 100 : 0)
            
        case "fours":
            return dicesNumberArray.filter({$0 == 4}).reduce(0, +) + (yathzee && alreadyYathzee ? 100 : 0)
            
        case "fives" :
            return dicesNumberArray.filter({$0 == 5}).reduce(0, +) + (yathzee && alreadyYathzee ? 100 : 0)
            
        case "sixes" :
            return dicesNumberArray.filter({$0 == 6}).reduce(0, +) + (yathzee && alreadyYathzee ? 100 : 0)
            
        // Three of a kind: if at least 3 dice show the same number, sum all dice + possible Yahtzee bonus
        case "threeOfAKind" :
            for i in 1 ... 6 {
                if dicesNumberArray.filter({$0 == i}).count >= 3 {
                    return dicesNumberArray.reduce(0, +) + (yathzee && alreadyYathzee ? 100 : 0)
                }
            }
            return 0
            
        // Four of a kind: if at least 4 dice show the same number, sum all dice + possible Yahtzee bonus
        case "fourOfAKind" :
            for i in 1 ... 6 {
                if dicesNumberArray.filter({$0 == i}).count >= 4 {
                    return dicesNumberArray.reduce(0, +) + (yathzee && alreadyYathzee ? 100 : 0)
                }
            }
            return 0
            
        // Full house: exactly 3 of one number and exactly 2 of another different number → 25 points + Yahtzee bonus
        case "fullHouse" :
            for i in 1 ... 6 {
                if dicesNumberArray.filter({$0 == i}).count == 3 {
                    for j in 1 ... 6 {
                        if (dicesNumberArray.filter({$0 == j}).count == 2) && (i != j) {
                            return 25 + (yathzee && alreadyYathzee ? 100 : 0)
                        }
                    }
                }
            }
            return 0 + (yathzee && alreadyYathzee ? 100 : 0)
            
        // Small straight: sequence of 4 consecutive numbers → 30 points + Yahtzee bonus
        // Check using presence of 3 and 4 plus one of three possible pairs to form the straight
        case "smallStraight" :
            if dicesNumberArray.contains(3) && dicesNumberArray.contains(4) {
                if dicesNumberArray.contains(1) && dicesNumberArray.contains(2)
                    || dicesNumberArray.contains(2) && dicesNumberArray.contains(5)
                    || dicesNumberArray.contains(5) && dicesNumberArray.contains(6) {
                    return 30 + (yathzee && alreadyYathzee ? 100 : 0)
                }
            }
            return 0 + (yathzee && alreadyYathzee ? 100 : 0)
            
        // Large straight: sequence of 5 consecutive numbers → 40 points + Yahtzee bonus
        // Check if dice contains 2,3,4,5 plus either 1 or 6 to complete the sequence
        case "largeStraight" :
            if dicesNumberArray.contains(2) && dicesNumberArray.contains(3) && dicesNumberArray.contains(4) && dicesNumberArray.contains(5){
                if dicesNumberArray.contains(1) || dicesNumberArray.contains(6) {
                    return 40 + (yathzee && alreadyYathzee ? 100 : 0)
                }
            }
            return 0 + (yathzee && alreadyYathzee ? 100 : 0)
            
        // Yahtzee: all dice have the same number → 50 points
        // No bonus points applied here because it’s the main Yahtzee category
        case "yahtzee" :
            return (yathzee ? 50 : 0)

        // Chance: sum of all dice + Yahtzee bonus if applicable
        case "chance" :
            return dicesNumberArray.reduce(0, +) + (yathzee && alreadyYathzee ? 100 : 0)
            
        default:
            // Invalid category returns -1
            return -1
            
        } // switch
    }
    
}
