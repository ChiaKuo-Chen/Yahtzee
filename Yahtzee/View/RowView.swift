//
//  RowView.swift
//  Yahtzee
//

import SwiftUI
import SwiftData

struct RowView: View {

    // MARK: - PROPERTIES
    @Query var gamedata: [GameData]
    let categorymodel = CategoryModel()

    let category: String
    let backGroundColor: String
    

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

                    SecondPanelView(category: category)

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
}


#Preview {
    let container = try! ModelContainer(for: GameData.self, Dice.self, ScoreBoard.self)
    let context = container.mainContext
    let previewGameData = generateInitialData()

    context.insert(previewGameData)
    try? context.save()
    
    return RowView(category: "threes", backGroundColor: "27ae60")
        .modelContainer(container)
        .environmentObject(PenObject())
}


