//
//  RowView.swift
//  Yahtzee
//

import SwiftUI

struct RowView: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var scoreboard : ScoreBoard
    let categorymodel = CategoryModel()

    let category: String
    let backGroundColor: String
    let dicesArray: [Dice]
    

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

                    SecondPanelView(category: category, dicesArray: dicesArray)

                    // SECOND PANEL


                    ZStack {
                        Image("emptyPanel")
                            .resizable()
                            .scaledToFit()
                        
                        Text(categorymodel.returnRuleString(category))
                            .lineLimit(nil)
                            .fontWeight(.bold)
                            .font(category.count<6 ? .subheadline : .caption )
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
    
    struct Preview: View {
        
        
        var body: some View {
            RowView(category: "threes", backGroundColor: "27ae60", dicesArray: Array(repeating: Dice(value: 3), count: 5))
                .environmentObject(ScoreBoard())
        }
    }
    return Preview()

}

