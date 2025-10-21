//
//  RowView.swift
//  Yahtzee
//
//  A full row representing a single scoring category in the Yahtzee score sheet.
//  Contains:
//  1. An icon (left)
//  2. The main score panel (middle, interactive)
//  3. The rule description (right)
//
//  Created by 陳嘉國
//

import SwiftUI
import SwiftData

struct PanelRowView: View {
    
    // MARK: - PROPERTIES

    // Game state data, including dice and scores
    @Bindable var gameData: GameData

    // Rule-related helper (image names, rule descriptions)
    let categorymodel = CategoryModel()

    // This row's scoring category (e.g., "threes", "yahtzee", etc.)
    let category: String

    // Background color hex string for this row
    let backGroundColor: String

    // A shorthand for matching numeric upper-section categories
    let list23456 = ["twos", "threes", "fours", "fives", "sixes"]

    // MARK: - BODY
    
    var body: some View {
        
        HStack {
            
            // FIRST PANEL: Category icon (e.g., "dice3", "yahtzee", etc.)
            if category != "yahtzee" {
                Image(categorymodel.returnPicString(category))
                    .resizable()
                    .scaledToFit()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(UIColor.white), lineWidth: 2)
                    )
            } else {
                // Yahtzee uses special red panel background
                Image("redPanel")
                    .resizable()
                    .scaledToFit()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(UIColor.white), lineWidth: 2)
                    )
            }
            
            // SECOND PANEL: Interactive score cell
            SecondPanelView(gameData: gameData, category: category)
            
            // THIRD PANEL: Rule description text
            Image("emptyPanel")
                .resizable()
                .scaledToFit()
                .overlay {
                    Text(categorymodel.returnRuleString(category))
                        .lineLimit(nil)
                        .fontWeight(.black)
                        .font(category.count < 8 ? (category.count < 6 ? .callout : .caption) : .caption2)
                        .multilineTextAlignment(.center)
                        .lineSpacing(8)
                        .foregroundStyle(Color.white)
                        .shadow(color: Color.black, radius: 2, y: 2)
                }
        } // HSTACK
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        // Special visual treatment for Yahtzee row
        .overlay(
            HStack {
                if category == "yahtzee" {
                    ForEach(0..<3, id: \.self) { index in
                        Image("yahtzee")
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(1.2)
                            .shadowFrame(frameSize: 1)
                            .shadowFrame(color: Color.white, frameSize: 1)
                            .opacity(index == 0 ? 1 : 0) // Only show on the left Cell
                    }
                }
            } // HSTACK
        )
        .background(
            PanelBackgroundView(category: category, backGroundColor: backGroundColor)
        )
        
    }
    
    // MARK: - TO SIMPLIFY THE CODE

    // Index of the category in scoreboard
    var categoryIndex: Int { categorymodel.returnIndex(category) }

    // Whether this score has been written (non-nil)
    var scoreAlreadyWritten: Bool { writtenScore != nil }

    // Written score (if any)
    var writtenScore: Int? { gameData.scoreboard[0].scoresArray[categoryIndex] }

}


#Preview ("one") {
    let container = try! ModelContainer(for: GameData.self, Dice.self, ScoreBoard.self)
    let previewGameData = generateInitialData()
    let penObject = PenObject()
    
    PanelRowView(gameData: previewGameData, category: "ones", backGroundColor: "27ae60")
        .environmentObject(penObject)
        .modelContainer(container)
}

#Preview ("threeOfAKind") {
    let container = try! ModelContainer(for: GameData.self, Dice.self, ScoreBoard.self)
    let previewGameData = generateInitialData()
    let penObject = PenObject()
    
    PanelRowView(gameData: previewGameData, category: "threeOfAKind", backGroundColor: "27ae60")
        .environmentObject(penObject)
        .modelContainer(container)
}


#Preview ("yahtzee"){
    let container = try! ModelContainer(for: GameData.self, Dice.self, ScoreBoard.self)
    let previewGameData = generateInitialData()
    let penObject = PenObject()
    
    return PanelRowView(gameData: previewGameData, category: "yahtzee", backGroundColor: "27ae60")
        .environmentObject(penObject)
        .modelContainer(container)
    
}
