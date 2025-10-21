//
//  BoardView.swift
//  Yahtzee
//
//  This view composes the full score board for a Yahtzee game,
//  arranging multiple scoring category rows and the bonus AddUp view.
//  The board is organized in pairs of categories displayed horizontally,
//  grouped vertically in a VStack.
//
//  Created by 陳嘉國
//

import SwiftUI
import SwiftData

struct BoardView: View {
    
    // MARK: - PROPERTIES
    
    // The main game data model containing dice, scores, and game state
    @Bindable var gameData: GameData // SwiftData bound model
    
    // Two alternating background colors for board rows, in hex string format
    let boardBackgroundColor1 = "27ae60"
    let boardBackgroundColor2 = "16a085"

    // MARK: - BODY
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            // Each HStack contains two PanelRowViews side-by-side,
            // alternating background colors for visual distinction

            HStack(spacing: 0) {
                PanelRowView(gameData: gameData, category: "ones", backGroundColor: boardBackgroundColor1)
                
                PanelRowView(gameData: gameData, category: "threeOfAKind", backGroundColor: boardBackgroundColor1)
            }
            
            HStack(spacing: 0) {
                PanelRowView(gameData: gameData, category: "twos", backGroundColor: boardBackgroundColor2)
                
                PanelRowView(gameData: gameData, category: "fourOfAKind", backGroundColor: boardBackgroundColor2)
            }
            
            HStack(spacing: 0) {
                PanelRowView(gameData: gameData, category: "threes", backGroundColor: boardBackgroundColor1)
                
                PanelRowView(gameData: gameData, category: "fullHouse", backGroundColor: boardBackgroundColor1)
            }
            
            HStack(spacing: 0) {
                PanelRowView(gameData: gameData, category: "fours", backGroundColor: boardBackgroundColor2)
                
                PanelRowView(gameData: gameData, category: "smallStraight", backGroundColor: boardBackgroundColor2)
            }
            
            HStack(spacing: 0) {
                PanelRowView(gameData: gameData, category: "fives", backGroundColor: boardBackgroundColor1)
                
                PanelRowView(gameData: gameData, category: "largeStraight", backGroundColor: boardBackgroundColor1)            }
            
            HStack(spacing: 0) {
                PanelRowView(gameData: gameData, category: "sixes", backGroundColor: boardBackgroundColor2)
                
                PanelRowView(gameData: gameData, category: "yahtzee", backGroundColor: boardBackgroundColor2)
            }
            
            // Bottom row contains the upper section AddUpView (bonus +35 if ≥ 63)
            // and the 'chance' category panel

            HStack(spacing: 0) {
                AddUpView(addUp: gameData.scoreboard[0].returnAddUpScore(), backGroundColor: boardBackgroundColor1)
                
                PanelRowView(gameData: gameData, category: "chance", backGroundColor: boardBackgroundColor1)
            }
            
        } // VSTACK
        // Board styling: rounded corners and subtle shadow for elevation
        .background()
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 2, y: 2)

    }
}


#Preview {
    
    let container = try! ModelContainer(for: GameData.self, Dice.self, ScoreBoard.self)
    let previewGameData = generateInitialData()
    let penObject = PenObject()

    BoardView(gameData: previewGameData)
        .environmentObject(penObject)
        .modelContainer(container)
}

