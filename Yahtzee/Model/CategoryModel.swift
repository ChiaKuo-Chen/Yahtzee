//
//  IndexModel.swift
//  Yahtzee
//

import Foundation

enum Category: String, CaseIterable {
    
    case ones, twos, threes, fours, fives, sixes
    case threeOfAKind, fourOfAKind, fullHouse, smallStraight, largeStraight, yahtzee, chance

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

    static func category(at index: Int) -> Category? {
        guard index >= 0 && index < Category.allCases.count else { return nil }
        return Category.allCases[index]
    }

    var index: Int {
        return Category.allCases.firstIndex(of: self)!
    }
}

class CategoryModel {

    func returnCategory(_ index: Int) -> String {
        return Category.category(at: index)?.rawValue ?? ""
    }

    func returnIndex(_ category: String) -> Int {
        return Category(rawValue: category)?.index ?? -1
    }

    func returnPicString(_ category: String) -> String {
        guard let cat = Category(rawValue: category) else { return "" }
        return cat.pictureName
    }

    func returnRuleString(_ category: String) -> String {
        guard let cat = Category(rawValue: category) else { return "" }
        return cat.displayName
    }
}
