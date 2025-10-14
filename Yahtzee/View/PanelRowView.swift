//
//  RowView.swift
//  Yahtzee
//

import SwiftUI
import SwiftData

struct PanelRowView: View {
    
    // MARK: - PROPERTIES
    @Bindable var gameData: GameData
    let categorymodel = CategoryModel()
    let category: String
    let backGroundColor: String
    let list23456 = ["twos", "threes", "fours", "fives", "sixes"]
    
    // MARK: - BODY
    
    var body: some View {
        
        HStack {
            
            // FIRST PANEL
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
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(UIColor.white), lineWidth: 2)
                    )
            }
            
            // SECOND PANEL
            SecondPanelView(gameData: gameData, category: category)
            
            // THIRD PANEL
            Image("emptyPanel")
                .resizable()
                .scaledToFit()
                .overlay{
                    Text(categorymodel.returnRuleString(category))
                        .lineLimit(nil)
                        .fontWeight(.black)
                        .font(category.count<8 ? (category.count<6 ? .callout : .caption) : .caption2 )
                        .multilineTextAlignment(.center)
                        .lineSpacing(8)
                        .foregroundStyle(Color.white)
                        .shadow(color: Color.black, radius: 2, y: 2)
                }
            
        } // HSTACK
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .overlay(
            HStack {
                if category == "yahtzee" {
                    ForEach(0..<3, id: \.self) { index in
                        Image("yahtzee")
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(1.2)
                            .shadowFrame(frameSize: 1)
                            .shadowFrame(color: Color.white, frameSize: 1)
                            .opacity(index==0 ? 1 : 0)
                    }
                }
            } // HSTACK
        )
        .background(
            PanelBackgroundView(category: category, backGroundColor: backGroundColor)
        )
        
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
    
    PanelRowView(gameData: previewGameData, category: "ones", backGroundColor: "27ae60")
        .environmentObject(penObject)
        .modelContainer(container)
}

#Preview ("threeOfAKind") {
    let container = try! ModelContainer(for: GameData.self, Dice.self, ScoreBoard.self)
    let previewGameData = generateInitialData()
    let penObject = PenObject()
    
    PanelRowView(gameData: previewGameData, category: "threeOfAKind", backGroundColor: "27ae60")
        .environmentObject(penObject)
        .modelContainer(container)
}


#Preview ("yahtzee"){
    let container = try! ModelContainer(for: GameData.self, Dice.self, ScoreBoard.self)
    let previewGameData = generateInitialData()
    let penObject = PenObject()
    
    return PanelRowView(gameData: previewGameData, category: "yahtzee", backGroundColor: "27ae60")
        .environmentObject(penObject)
        .modelContainer(container)
    
}
