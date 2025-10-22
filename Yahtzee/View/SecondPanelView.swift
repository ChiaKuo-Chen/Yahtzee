//
//  SecondPanelView.swift
//  Yahtzee
//
//  A single panel in the score table (like a cell).
//  Displays either the calculated score for a rule (e.g. "Threes")
//  or a fixed score if already written.
//
//  Allows player to select which rule to apply the current dice to.
//
//  Created by 陳嘉國
//

import SwiftUI
import SwiftData

struct SecondPanelView: View {
    
    // MARK: - PROPERTIES
    
    // Object representing the "pen", i.e., which score cell the player wants to write in.
    @EnvironmentObject var penObject: PenObject
    
    // The main game data model containing dice, scores, and game state
    @Bindable var gameData: GameData // SwiftData bound model

    // MARK: - CONSTANTS
    
    // The current rule category this panel represents (e.g., "threes", "yahtzee", etc.)
    let category: String

    // Rule-related helper (image names, rule descriptions)
    let categoryModel = CategoryModel()

    // Score calculator for dice based on rule.
    let scoreModel = ScoreModel()
    
    private let unselectPanelColor = "#d8ffb2"
    
    // Lighting effect colors for visual style
    private let lightingColor = [Color.white.opacity(1), Color.clear,
                                 Color.clear, Color.clear]
    
    // MARK: - COMPUTED PROPERTIES
    
    // Current dice array from game data.
    var diceArray: [Dice] { gameData.diceArray }

    // The main scoreboard (we assume single player for now).
    var scoreboard: ScoreBoard { gameData.scoreboard[0] }

    // The score this panel *would* have, if selected and applied.
    var potentialScore: Int {
        scoreModel.calculateScore(diceArray, category: category, scoreBoard: scoreboard)
    }
    
    // The index for this category in the scoreboard array.
    var categoryIndex: Int {
        categoryModel.returnIndex(category)
    }
    
    // Whether this panel already has a score written (cannot be changed).
    var scoreAlreadyWritten: Bool {
        writtenScore != nil
    }
    
    // The actual written score, if any.
    var writtenScore: Int? {
        scoreboard.scoresArray[categoryIndex]
    }
    
    // The current "pen target", i.e., selected cell to write score into.
    var penTarget: Int? {
        penObject.penTarget
    }
    
    // Background color for the panel, depending on state.
    var panelColor: Color {
        if scoreAlreadyWritten {
            return Color.white
        } else if categoryIndex == penTarget {
            return Color.green
        } else {
            return Color(UIColor(hex: unselectPanelColor))
        }
    }

    // MARK: - BODY
    var body: some View {
        
        RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(panelColor)
            .scaledToFit()
            .shadow(color: Color.black,
                    radius: 0,
                    x: scoreAlreadyWritten ? 0 : 2,
                    y: scoreAlreadyWritten ? 0 : 3)
            .shadow(color: Color.black,
                    radius: 0,
                    x: scoreAlreadyWritten ? 0 : -2,
                    y: scoreAlreadyWritten ? 0 : 3)
        // MARK: - Score Display
            .overlay {
                if scoreAlreadyWritten {
                    Text("\(writtenScore!)")
                        .font(writtenScore! <= 99 ? .title : .title2)
                        .fontWeight(.black)
                        .foregroundStyle(.black)
                } else {
                    Text("\(potentialScore)")
                        .font(potentialScore <= 99 ? .title : .title2)
                        .fontWeight(.black)
                        .foregroundStyle(categoryIndex == penTarget ? .black : .gray)
                }
            }
        // MARK: - Lighting Overlay (visual only)
            .overlay{
                if panelColor == Color(UIColor(hex: unselectPanelColor)) {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(
                            LinearGradient(
                                colors: lightingColor,
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                }
            }
        // MARK: - Raise effect
            .offset(y: scoreAlreadyWritten ? 0 : -6)
        
        // MARK: - Tapping Behavior
            .onTapGesture {
                if scoreAlreadyWritten {
                    penObject.leavePaper()
                } else {
                    penObject.takePaper(categoryIndex)
                }
            }
        
        
    }
    
}

#Preview {
    let container = try! ModelContainer(for: GameData.self, Dice.self, ScoreBoard.self)
    let previewGameData = generateInitialData()
    let penObject = PenObject()
    
    return SecondPanelView(gameData: previewGameData, category: "threes")
        .environmentObject(penObject)
        .modelContainer(container)
        .padding(.vertical, 100)
        .padding()
        .background(Color.blue)
}
