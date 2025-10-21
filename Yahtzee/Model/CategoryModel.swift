//
//  IndexModel.swift
//  Yahtzee
//
//  Defines the categories for scoring in Yahtzee,
//  and provides helper methods for accessing category properties.
//
//  Created by 陳嘉國
//

import Foundation

// Enum representing all Yahtzee scoring categories.
// Each case corresponds to a specific scoring rule.
enum Category: String, CaseIterable {
    
    // Upper section categories: score by sum of dice matching the number
    case ones, twos, threes, fours, fives, sixes
    
    // Lower section categories with special rules
    case threeOfAKind, fourOfAKind, fullHouse, smallStraight, largeStraight, yahtzee, chance

    // Returns the display name for each category.
    var displayName: String {
        switch self {
        case .ones: return "Ones"
        case .twos: return "Twos"
        case .threes: return "Threes"
        case .fours: return "Fours"
        case .fives: return "Fives"
        case .sixes: return "Sixes"
        case .threeOfAKind: return "Three of a kind"
        case .fourOfAKind: return "Four of a kind"
        case .fullHouse: return "Full House"
        case .smallStraight: return "Small Straight"
        case .largeStraight: return "Large Straight"
        case .yahtzee: return "Yahtzee"
        case .chance: return "Chance"
        }
    }

    // Returns the image name associated with each category (for UI icons).
    var pictureName: String {
        switch self {
        case .ones: return "redDice1"
        case .twos: return "redDice2"
        case .threes: return "redDice3"
        case .fours: return "redDice4"
        case .fives: return "redDice5"
        case .sixes: return "redDice6"
        case .threeOfAKind: return "red3x"
        case .fourOfAKind: return "red4x"
        case .fullHouse: return "redHouse"
        case .smallStraight: return "redSmall"
        case .largeStraight: return "redLarge"
        case .yahtzee: return "yahtzee"
        case .chance: return "redChance"
        }
    }

    // Returns the category for a given index in the enum cases list.
    // Returns nil if index is out of range.
    static func category(at index: Int) -> Category? {
        guard index >= 0 && index < Category.allCases.count else { return nil }
        return Category.allCases[index]
    }

    // Returns the index of the current category in the allCases list.
    var index: Int {
        return Category.allCases.firstIndex(of: self)!
    }
}

// Helper class to convert between category index, rawValue, and UI strings.
class CategoryModel {

    // Returns the rawValue string for a category at given index.
    // Returns empty string if index invalid.
    func returnCategory(_ index: Int) -> String {
        return Category.category(at: index)?.rawValue ?? ""
    }

    // Returns the index of a category given its rawValue string.
    // Returns -1 if not found.
    func returnIndex(_ category: String) -> Int {
        return Category(rawValue: category)?.index ?? -1
    }

    // Returns the image name string for a given category rawValue.
    func returnPicString(_ category: String) -> String {
        guard let cat = Category(rawValue: category) else { return "" }
        return cat.pictureName
    }

    // Returns the display name string for a given category rawValue.
    func returnRuleString(_ category: String) -> String {
        guard let cat = Category(rawValue: category) else { return "" }
        return cat.displayName
    }
}
