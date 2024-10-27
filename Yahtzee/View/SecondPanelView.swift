//
//  SecondPanelView.swift
//  Yahtzee
//

import SwiftUI

struct SecondPanelView: View {
    
    // MARK: - PROPERTIES
    @EnvironmentObject var scoreboard : ScoreBoard
    let categorymodel = CategoryModel()
    let scoremodel = ScoreModel()
    
    let category: String
    let dicesArray: [Dice]
    
    private let unselectPanelColor = "#d8ffb2"
    
    // MARK: - BODY
    
    var body: some View {
        
        let score = scoremodel.caculateScore(dicesArray, index: categorymodel.returnIndex(category))
        let index = categorymodel.returnIndex(category)
        let scoreAlreadyWritten = ( scoreboard.scoresArray[ categorymodel.returnIndex(category) ] != nil )

        RoundedRectangle(cornerRadius: 10)
            .fill(Color.white)
            .fill( scoreAlreadyWritten ? Color.white : ( index == scoreboard.penTarget ? Color.green : Color(UIColor(hex: unselectPanelColor)) ) )
            .scaledToFit()
            .shadow(radius: 0, y: 6)
            .overlay{
                if scoreAlreadyWritten {
                    Text("\(scoreboard.scoresArray[index]!)")
                        .font(scoreboard.scoresArray[index]!<=99 ? .title : .subheadline)
                        .fontWeight(.black)
                        .foregroundStyle(.black)
                } else {
                    Text("\(score)")
                        .font(score<=99 ? .title : .subheadline)
                        .fontWeight(.black)
                        .foregroundStyle( index == scoreboard.penTarget ? .black : .gray)
                }
            }
            .onTapGesture {
                if !(scoreAlreadyWritten) {
                    
                    if index != scoreboard.penTarget {
                        scoreboard.penTarget = index
                    } else {
                        scoreboard.penTarget = nil
                    }
                }
            }
        
    }
}

#Preview {
    
    struct Preview: View {
        @State var diceArray = Array(repeating: Dice(value: 3), count: 5)
        
        var body: some View {
            SecondPanelView(category: "threes", dicesArray: diceArray)
                .environmentObject(ScoreBoard())
        }
    }
    return Preview()
    
}
