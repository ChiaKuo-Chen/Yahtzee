//
//  SecondPanelView.swift
//  Yahtzee
//

import SwiftUI
import SwiftData

struct SecondPanelView: View {
    
    // MARK: - PROPERTIES
    @Query var gamedata: [GameData]
    let categorymodel = CategoryModel()
    let scoremodel = ScoreModel()
    
    let category: String
    
    private let unselectPanelColor = "#d8ffb2"

    // MARK: - BODY
    
    var body: some View {
        

        RoundedRectangle(cornerRadius: 10)
            .fill(Color.white)
            .fill( scoreAlreadyWritten ? Color.white : ( categoryIndex == pentarget ? Color.green : Color(UIColor(hex: unselectPanelColor)) ) )
            .scaledToFit()
            .shadow(radius: 0, y: 6)
            .overlay{
                if scoreAlreadyWritten {
                    Text("\(writtenScore!)")
                        .font(writtenScore!<=99 ? .title : .subheadline)
                        .fontWeight(.black)
                        .foregroundStyle(.black)
                } else {
                    Text("\(potentialScore)")
                        .font(potentialScore<=99 ? .title : .subheadline)
                        .fontWeight(.black)
                        .foregroundStyle( categoryIndex == pentarget ? .black : .gray)
                }
            }
            .onTapGesture {
                if !(scoreAlreadyWritten) {
                    
                    if categoryIndex != pentarget {
                        gamedata[0].scoreboard[0].penTarget = categoryIndex
                    } else {
                        gamedata[0].scoreboard[0].penTarget = nil
                    }
                }
                
            }
        
    }
    
    // MARK: - TO SIMPLY THE CODE
    
    var potentialScore : Int { scoremodel.caculateScore(gamedata[0].diceArray, category: category) }
    var categoryIndex : Int { categorymodel.returnIndex(category) }
    var scoreAlreadyWritten : Bool { ( writtenScore != nil ) }
    var writtenScore : Int? { gamedata[0].scoreboard[0].scoresArray[categoryIndex] }
    var pentarget : Int? { gamedata[0].scoreboard[0].penTarget }


}

#Preview {
    
    struct Preview: View {
        
        var body: some View {
            SecondPanelView(category: "threes")
                .modelContainer(for: GameData.self)
        }
    }
    return Preview()
    
}
