//
//  BoardView.swift
//  Yahtzee

import SwiftUI

struct BoardView: View {
    
    // MARK: - PROPERTIES
    @EnvironmentObject var scoreboard : ScoreBoard
    @Binding var dicesArray :[Dice]

    let boardBackgroundColor1 = "27ae60"
    let boardBackgroundColor2 = "16a085"
    
    // MARK: - BODY
    
    var body: some View {
        
        
        VStack(spacing: 0) {
            
            HStack(spacing: 0) {
                RowView(image: "redDice1", backGroundColor: boardBackgroundColor1, dicesArray: dicesArray)
                                
                RowView(image: "red3x", backGroundColor: boardBackgroundColor1, dicesArray: dicesArray)
            }
            
            HStack(spacing: 0) {
                RowView(image: "redDice2", backGroundColor: boardBackgroundColor2, dicesArray: dicesArray)
                
                RowView(image: "red4x", backGroundColor: boardBackgroundColor2, dicesArray: dicesArray)
            }
            
            HStack(spacing: 0) {
                RowView(image: "redDice3", backGroundColor: boardBackgroundColor1, dicesArray: dicesArray)
                
                RowView(image: "redHouse", backGroundColor: boardBackgroundColor1, dicesArray: dicesArray)
            }
            
            HStack(spacing: 0) {
                RowView(image: "redDice4", backGroundColor: boardBackgroundColor2, dicesArray: dicesArray)
                
                RowView(image: "redSmall", backGroundColor: boardBackgroundColor2, dicesArray: dicesArray)
            }
            
            HStack(spacing: 0) {
                RowView(image: "redDice5", backGroundColor: boardBackgroundColor1, dicesArray: dicesArray)
                
                RowView(image: "redLarge", backGroundColor: boardBackgroundColor1, dicesArray: dicesArray)
            }
            
            HStack(spacing: 0) {
                RowView(image: "redDice6", backGroundColor: boardBackgroundColor2, dicesArray: dicesArray)
                
                RowView(image: "yahtzee", backGroundColor: boardBackgroundColor2, dicesArray: dicesArray)
            }
            
            
            HStack(spacing: 0) {
                AddUpView(addUp: scoreboard.returnAddUpScore(), backGroundColor: boardBackgroundColor1)
                
                RowView(image: "redChance", backGroundColor: boardBackgroundColor1, dicesArray: dicesArray)
            }
            
        }// VSTACK
        .clipShape(RoundedRectangle(cornerRadius: 20))

    }
}

#Preview {
    
    struct Preview: View {
        
        @State var dicearray = Array(repeating: Dice(value: 3), count: 5)
        var body: some View {
            BoardView(dicesArray: $dicearray)
                .environmentObject(ScoreBoard())
        }
    }
    return Preview()

}

