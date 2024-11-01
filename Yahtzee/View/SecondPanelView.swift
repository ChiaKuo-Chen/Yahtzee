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
            .fill( scoreAlreadyWritten() ? Color.white : ( categoryIndex() == pentarget() ? Color.green : Color(UIColor(hex: unselectPanelColor)) ) )
            .scaledToFit()
            .shadow(radius: 0, y: 6)
            .overlay{
                if scoreAlreadyWritten() {
                    Text("\(writtenScore()!)")
                        .font(writtenScore()!<=99 ? .title : .subheadline)
                        .fontWeight(.black)
                        .foregroundStyle(.black)
                } else {
                    Text("\(potentialScore())")
                        .font(potentialScore()<=99 ? .title : .subheadline)
                        .fontWeight(.black)
                        .foregroundStyle( categoryIndex() == pentarget() ? .black : .gray)
                }
            }
            .onTapGesture {
                if !(scoreAlreadyWritten()) {
                    
                    if categoryIndex() != pentarget() {
                        gamedata[0].scoreboard[0].penTarget = categoryIndex()
                    } else {
                        gamedata[0].scoreboard[0].penTarget = nil
                    }
                }
                
            }
        
    }
    
    // MARK: - FUNCTION TO REPLY VALUE
    
    func categoryIndex() -> Int { return categorymodel.returnIndex(category) }
    func potentialScore() -> Int { return scoremodel.caculateScore(gamedata[0].diceArray, index: categoryIndex()) }
    func writtenScore() -> Int? { return gamedata[0].scoreboard[0].scoresArray[categoryIndex()] }
    func scoreAlreadyWritten() -> Bool { return  ( writtenScore() != nil ) }
    func pentarget() -> Int? { return  gamedata[0].scoreboard[0].penTarget }


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
