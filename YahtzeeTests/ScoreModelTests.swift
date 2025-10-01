//
//  YahtzeeTests.swift
//  YahtzeeTests
//
//  Created by 陳嘉國
//

import XCTest
@testable import Yahtzee
import SwiftData

final class ScoreModelTests: XCTestCase {

    func testOnesScore() {
        let scoremodel = ScoreModel()
        let diceArray = [1, 1, 2, 3, 4].map { Dice(value: $0, isHeld: false, isRoll: 0) }
        let scoreBoard = MockScoreBoard(alreadyYahtzee: false)
        let result = scoremodel.calculateScore(diceArray, category: "ones", scoreBoard: scoreBoard)
        XCTAssertEqual(result, 2)
    }

    func testYahtzeeScore() {
        let scoremodel = ScoreModel()
        let diceArray = Array(repeating: Dice(value: 6, isHeld: false, isRoll: 0), count: 5)
        let scoreBoard = MockScoreBoard(alreadyYahtzee: false)
        let result = scoremodel.calculateScore(diceArray, category: "yahtzee", scoreBoard: scoreBoard)
        XCTAssertEqual(result, 50)
    }

    func testFullHouseScore() {
        let scoremodel = ScoreModel()
        let diceArray = [3, 3, 3, 5, 5].map { Dice(value: $0, isHeld: false, isRoll: 0) }
        let scoreBoard = MockScoreBoard(alreadyYahtzee: false)
        let result = scoremodel.calculateScore(diceArray, category: "fullHouse", scoreBoard: scoreBoard)
        XCTAssertEqual(result, 25)
    }

    func testChanceScore() {
        let scoremodel = ScoreModel()
        let diceArray = [2, 3, 4, 5, 6].map { Dice(value: $0, isHeld: false, isRoll: 0) }
        let scoreBoard = MockScoreBoard(alreadyYahtzee: false)
        let result = scoremodel.calculateScore(diceArray, category: "chance", scoreBoard: scoreBoard)
        XCTAssertEqual(result, 20)
    }

    func testThreeOfAKindScore() {
        let scoremodel = ScoreModel()
        let diceArray = [2, 2, 2, 4, 6].map { Dice(value: $0, isHeld: false, isRoll: 0) }
        let scoreBoard = MockScoreBoard(alreadyYahtzee: false)
        let result = scoremodel.calculateScore(diceArray, category: "threeOfAKind", scoreBoard: scoreBoard)
        XCTAssertEqual(result, 16)
    }

    func testYahtzeeBonusScore() {
        let scoremodel = ScoreModel()
        let diceArray = Array(repeating: Dice(value: 5, isHeld: false, isRoll: 0), count: 5)
        let scoreBoard = MockScoreBoard(alreadyYahtzee: true)
        let result = scoremodel.calculateScore(diceArray, category: "fives", scoreBoard: scoreBoard)
        XCTAssertEqual(result, 125) // 25 + 100 bonus
    }
}

// MARK: - MockScoreBoard
class MockScoreBoard: ScoreBoard {
    private let yahtzeeFlag: Bool

    init(alreadyYahtzee: Bool) {
        self.yahtzeeFlag = alreadyYahtzee
        super.init()
        if yahtzeeFlag {
            self.scoresArray[11] = 50
        } else {
            self.scoresArray[11] = nil
        }
    }
    
    // No Init
    required init(backingData: any BackingData<ScoreBoard>) {
        fatalError("init(backingData:) has not been implemented")
    }
    

    override func wetherAlreadyYahtzee() -> Bool {
        return yahtzeeFlag
    }
}
