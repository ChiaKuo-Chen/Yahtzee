//
//  BoardView.swift
//  Yahtzee

import SwiftUI
import SwiftData

struct BoardView: View {
    
    // MARK: - PROPERTIES
    @Query var gamedata: [GameData]
    @Binding var dicesArray :[Dice]

    let boardBackgroundColor1 = "27ae60"
    let boardBackgroundColor2 = "16a085"
    
    // MARK: - BODY
    
    var body: some View {
        
        
        VStack(spacing: 0) {
            
            HStack(spacing: 0) {
                RowView(category: "ones", backGroundColor: boardBackgroundColor1, dicesArray: dicesArray)
                
                RowView(category: "threeOfAKind", backGroundColor: boardBackgroundColor1, dicesArray: dicesArray)
            }

            HStack(spacing: 0) {
                RowView(category: "twos", backGroundColor: boardBackgroundColor1, dicesArray: dicesArray)
                
                RowView(category: "fourOfAKind", backGroundColor: boardBackgroundColor1, dicesArray: dicesArray)
            }
            
            HStack(spacing: 0) {
                RowView(category: "threes", backGroundColor: boardBackgroundColor1, dicesArray: dicesArray)
                
                RowView(category: "fullHouse", backGroundColor: boardBackgroundColor1, dicesArray: dicesArray)
            }

            HStack(spacing: 0) {
                RowView(category: "fours", backGroundColor: boardBackgroundColor1, dicesArray: dicesArray)
                
                RowView(category: "smallStraight", backGroundColor: boardBackgroundColor1, dicesArray: dicesArray)
            }

            HStack(spacing: 0) {
                RowView(category: "fives", backGroundColor: boardBackgroundColor1, dicesArray: dicesArray)
                
                RowView(category: "largeStraight", backGroundColor: boardBackgroundColor1, dicesArray: dicesArray)
            }

            HStack(spacing: 0) {
                RowView(category: "sixes", backGroundColor: boardBackgroundColor1, dicesArray: dicesArray)
                
                RowView(category: "yahtzee", backGroundColor: boardBackgroundColor1, dicesArray: dicesArray)
            }

            HStack(spacing: 0) {
                AddUpView(addUp: gamedata[0].scoreboard[0].returnAddUpScore(), backGroundColor: boardBackgroundColor1)

                RowView(category: "chance", backGroundColor: boardBackgroundColor1, dicesArray: dicesArray)
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
                .modelContainer(for: GameData.self)
        }
    }
    return Preview()

}

