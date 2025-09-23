//
//  BoardView.swift
//  Yahtzee

import SwiftUI
import SwiftData

struct BoardView: View {
    
    // MARK: - PROPERTIES
    @Bindable var gameData: GameData

    let boardBackgroundColor1 = "27ae60"
    let boardBackgroundColor2 = "16a085"
    
    // MARK: - BODY
    
    var body: some View {
        
        
        VStack(spacing: 0) {
            
            HStack(spacing: 0) {
                RowView(gameData: gameData, category: "ones", backGroundColor: boardBackgroundColor1)
                
                RowView(gameData: gameData, category: "threeOfAKind", backGroundColor: boardBackgroundColor1)
            }
            
            HStack(spacing: 0) {
                RowView(gameData: gameData, category: "twos", backGroundColor: boardBackgroundColor2)
                
                RowView(gameData: gameData, category: "fourOfAKind", backGroundColor: boardBackgroundColor2)
            }
            
            HStack(spacing: 0) {
                RowView(gameData: gameData, category: "threes", backGroundColor: boardBackgroundColor1)
                
                RowView(gameData: gameData, category: "fullHouse", backGroundColor: boardBackgroundColor1)
            }
            
            HStack(spacing: 0) {
                RowView(gameData: gameData, category: "fours", backGroundColor: boardBackgroundColor2)
                
                RowView(gameData: gameData, category: "smallStraight", backGroundColor: boardBackgroundColor2)
            }
            
            HStack(spacing: 0) {
                RowView(gameData: gameData, category: "fives", backGroundColor: boardBackgroundColor1)
                
                RowView(gameData: gameData, category: "largeStraight", backGroundColor: boardBackgroundColor1)            }
            
            HStack(spacing: 0) {
                RowView(gameData: gameData, category: "sixes", backGroundColor: boardBackgroundColor2)
                
                RowView(gameData: gameData, category: "yahtzee", backGroundColor: boardBackgroundColor2)
            }
            
            HStack(spacing: 0) {
                AddUpView(addUp: gameData.scoreboard[0].returnAddUpScore(), backGroundColor: boardBackgroundColor1)
                
                RowView(gameData: gameData, category: "chance", backGroundColor: boardBackgroundColor1)
            }
            
        } // VSTACK
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

