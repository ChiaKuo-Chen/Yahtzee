//
//  ButtonViewModel.swift
//  Yahtzee
//
//  ViewModel for handling the game control buttons.
//  Manages dice rolling, scoring logic, game state updates, and navigation.
//  Coordinates between game data, UI state, and audio playback.
//
//  Created by 陳嘉國
//

import Foundation
import SwiftUI
import SwiftData

@Observable
@MainActor

// ViewModel for handling button interactions in the game,
// including dice rolling, scoring, and game state management.
class ButtonViewModel  {

    // MARK: - PROPERTIES
    
    // The main game data model containing dice, scores, and game state.
    var gameData: GameData
    
    // The scoreboard model representing the current player's scores and roll counts.
    var scoreboard: ScoreBoard
    
    // Current number of rolls left.
    var rollCount: Int {
        get { scoreboard.rollCount }
        set { scoreboard.rollCount = newValue }
    }

    private let modelContext: ModelContext   // SwiftData context for saving changes
    private let penObject: PenObject          // Object representing the selected score cell
    private let router: Router                 // Navigation router
    private let audioManager: AudioManager     // Handles audio playback for sound effects

    private let categoryModel = CategoryModel() // Model for score categories
    private let scoreModel = ScoreModel()       // Model to calculate scores based on dice

    // Array of dice currently in the game.
    var diceArray: [Dice] { gameData.diceArray }
    
    // Determines if the player can roll dice: must have rolls left and not all dice held.
    var canRoll: Bool {
        rollCount > 0 && diceArray.getDicesHeld().filter({ $0 == true }).count < diceArray.count
    }
    
    // Determines if the player can play (score) based on whether a score cell is selected.
    var canPlay: Bool { penObject.penTarget != nil }
    
    // The total score calculated from the scoreboard.
    var totalScore: Int { scoreboard.returnTotalScore() }
    
    // Checks if the game has ended by confirming all score cells are filled.
    var isGameEnd: Bool { !scoreboard.scoresArray.contains(nil) }

    // MARK: - INITIALIZER
    
    init(
        gameData: GameData,
        modelContext: ModelContext,
        penObject: PenObject,
        router: Router,
        audioManager: AudioManager = AudioManager()
    ) {
        self.gameData = gameData
        self.scoreboard = gameData.scoreboard[0]
        self.modelContext = modelContext
        self.penObject = penObject
        self.router = router
        self.audioManager = audioManager
    }

    // MARK: - METHODS
    
    // Rolls the dice if the player still has rolls left and not all dice are held.
    // Plays dice roll sound and updates dice values randomly.
    func rollDice() {
        guard canRoll else { return }

        audioManager.playSound(sound: "diceRoll", type: "mp3")

        for i in 0..<diceArray.count {
            diceArray[i].roll()
        }
        
        rollCount -= 1

        try? modelContext.save()

        // Check if all dice have the same value (Yahtzee) and navigate to Yahtzee animation page if true.
        for i in 1...6 {
            if diceArray.getDicesNumber().filter({ $0 == i }).count == diceArray.count {
                try? modelContext.save()
                router.path.append(.yahtzee)
            }
        }

    }

    // Processes the player's score selection asynchronously.
    // Calculates score, updates scoreboard, resets dice, and checks for game end.
    func play() async {
        guard let penIndex = penObject.penTarget else {
            print("penObject.penTarget is nil!")
            return
        }
        
        // Calculate new score based on dice and selected category
        let newScore = scoreModel.calculateScore(diceArray, category: categoryModel.returnCategory(penIndex), scoreBoard: scoreboard)
        scoreboard.updateScoreBoard(newScore: newScore, penIndex: penIndex)
        
        penObject.leavePaper() // Clear the selected scoring cell
        
        // Reset dice values and held states
        for i in 0..<diceArray.count {
            diceArray[i].value = 0
            diceArray[i].isHeld = false
        }
        
        // Small delay for animation smoothness
        try? await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds
        
        // Reset dice roll animation states
        for i in 0..<diceArray.count {
            diceArray[i].isRoll = 0
        }

        // Reset roll count for next round
        rollCount = 3

        try? modelContext.save()

        // Check if game is finished, then navigate to end page with final score.
        if !scoreboard.scoresArray.contains(nil) {
            router.path.append(.end(finalScore: scoreboard.returnTotalScore()))
        }
    }
    
    
}
