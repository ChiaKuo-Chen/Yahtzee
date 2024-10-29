//
//  BoardView.swift
//  Yahtzee

import SwiftUI
import SwiftData

struct BoardView: View {
    
    // MARK: - PROPERTIES
    @Query var gamedata: [GameData]
    
    let boardBackgroundColor1 = "27ae60"
    let boardBackgroundColor2 = "16a085"
    
    // MARK: - BODY
    
    var body: some View {
        
        
        VStack(spacing: 0) {
            
            HStack(spacing: 0) {
                RowView(category: "ones", backGroundColor: boardBackgroundColor1)
                
                RowView(category: "threeOfAKind", backGroundColor: boardBackgroundColor1)
            }
            
            HStack(spacing: 0) {
                RowView(category: "twos", backGroundColor: boardBackgroundColor1)
                
                RowView(category: "fourOfAKind", backGroundColor: boardBackgroundColor1)
            }
            
            HStack(spacing: 0) {
                RowView(category: "threes", backGroundColor: boardBackgroundColor1)
                
                RowView(category: "fullHouse", backGroundColor: boardBackgroundColor1)
            }
            
            HStack(spacing: 0) {
                RowView(category: "fours", backGroundColor: boardBackgroundColor1)
                
                RowView(category: "smallStraight", backGroundColor: boardBackgroundColor1)
            }
            
            HStack(spacing: 0) {
                RowView(category: "fives", backGroundColor: boardBackgroundColor1)
                
                RowView(category: "largeStraight", backGroundColor: boardBackgroundColor1)            }
            
            HStack(spacing: 0) {
                RowView(category: "sixes", backGroundColor: boardBackgroundColor1)
                
                RowView(category: "yahtzee", backGroundColor: boardBackgroundColor1)
            }
            
            HStack(spacing: 0) {
                AddUpView(addUp: gamedata[0].scoreboard[0].returnAddUpScore(), backGroundColor: boardBackgroundColor1)
                
                RowView(category: "chance", backGroundColor: boardBackgroundColor1)
            }
            
        } // VSTACK
        .clipShape(RoundedRectangle(cornerRadius: 20))

    }
}
#Preview {
    
    struct Preview: View {
        
        var body: some View {
            BoardView()
                .modelContainer(for: GameData.self)
        }
    }
    return Preview()
    
}

