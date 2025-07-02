//
//  SecondPanelView.swift
//  Yahtzee
//

import SwiftUI
import SwiftData

struct SecondPanelView: View {
    
    // MARK: - PROPERTIES
    @Query var gamedata: [GameData]
    @EnvironmentObject var penObject: PenObject
    
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
            .shadow(radius: 0, y: scoreAlreadyWritten ? 0 : 6)
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
                if scoreAlreadyWritten {
                    penObject.leavePaper()
                }
                else {
                    if categoryIndex != pentarget {
                        penObject.takePaper(categoryIndex)
                    }
                }
                
            }
        
        
    }
    
    // MARK: - TO SIMPLY THE CODE
    
    var potentialScore : Int { scoremodel.caculateScore(gamedata[0].diceArray, category: category) }
    var categoryIndex : Int { categorymodel.returnIndex(category) }
    var scoreAlreadyWritten : Bool { ( writtenScore != nil ) }
    var writtenScore : Int? { gamedata[0].scoreboard[0].scoresArray[categoryIndex] }
    var pentarget : Int? { penObject.penTarget }
    
    
}

#Preview {
    
    struct Preview: View {
        
        var body: some View {
            SecondPanelView(category: "threes")
                .environmentObject(PenObject())
                .modelContainer(for: GameData.self)
        }
    }
    return Preview()
    
}
