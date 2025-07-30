//
//  RowView.swift
//  Yahtzee
//

import SwiftUI
import SwiftData

struct RowView: View {

    // MARK: - PROPERTIES
    @Bindable var gameData: GameData
    let categorymodel = CategoryModel()
    let category: String
    let backGroundColor: String
    let list23456 = ["twos", "threes", "fours", "fives", "sixes"]
    
    // MARK: - BODY

    var body: some View {
        
            ZStack {
                HStack {
                    
                    if category != "yahtzee" {
                        Image(categorymodel.returnPicString(category))
                            .resizable()
                            .scaledToFit()
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(UIColor.white), lineWidth: 2)
                            )
                    } else {
                        Image("redPanel")
                            .resizable()
                            .scaledToFit()
                            .overlay(
                                Image("yahtzee")
                                    .resizable()
                                    .scaledToFit()
                                    .scaleEffect(1.3)
                                    .shadow(color: .black, radius: 0, x: 2, y: 2)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(UIColor.white), lineWidth: 2)
                            )

                    }
                    // FIRST PANEL

                    ZStack {
                        SecondPanelView(gameData: gameData, category: category)
                        
                    }

                    
                    // SECOND PANEL


                    ZStack {
                        Image("emptyPanel")
                            .resizable()
                            .scaledToFit()
                        
                        Text(categorymodel.returnRuleString(category))
                            .lineLimit(nil)
                            .fontWeight(.bold)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                            .lineSpacing(8)
                            .foregroundStyle(Color.white)
                    }
                    // THIRD PANEL
                    

                    
                } // HSTACK
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
                .background(
                    PanelBackgroundView(category: category, backGroundColor: backGroundColor)
                )
            } // ZSTACK
        
    }
    
    // MARK: - TO SIMPLY THE CODE
    var categoryIndex : Int { categorymodel.returnIndex(category) }
    var scoreAlreadyWritten : Bool { ( writtenScore != nil ) }
    var writtenScore : Int? { gameData.scoreboard[0].scoresArray[categoryIndex] }

}


#Preview ("one") {
    let container = try! ModelContainer(for: GameData.self, Dice.self, ScoreBoard.self)
    let previewGameData = generateInitialData()
    let penObject = PenObject()

    RowView(gameData: previewGameData, category: "ones", backGroundColor: "27ae60")
        .environmentObject(penObject)
        .modelContainer(container)
}

#Preview ("threeOfAKind") {
    let container = try! ModelContainer(for: GameData.self, Dice.self, ScoreBoard.self)
    let previewGameData = generateInitialData()
    let penObject = PenObject()

    RowView(gameData: previewGameData, category: "threeOfAKind", backGroundColor: "27ae60")
        .environmentObject(penObject)
        .modelContainer(container)
}


#Preview ("yahtzee"){
    let container = try! ModelContainer(for: GameData.self, Dice.self, ScoreBoard.self)
    let previewGameData = generateInitialData()
    let penObject = PenObject()
    
    return RowView(gameData: previewGameData, category: "yahtzee", backGroundColor: "27ae60")
        .environmentObject(penObject)
        .modelContainer(container)

}
