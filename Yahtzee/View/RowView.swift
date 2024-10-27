//
//  RowView.swift
//  Yahtzee
//

import SwiftUI

struct RowView: View {

    // MARK: - PROPERTIES
    let image: String
    let backGroundColor: String
    let dicesArray: [Dice]
    
    @EnvironmentObject var scoreboard : ScoreBoard

    // MARK: - BODY

    var body: some View {
        
            ZStack {
                HStack {
                    
                    if image != "yahtzee" {
                        Image(image)
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
                                Image(image)
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

                    SecondPanelView(image: image, dicesArray: dicesArray)

                    // SECOND PANEL


                    ZStack {
                        Image("emptyPanel")
                            .resizable()
                            .scaledToFit()
                        
                        Text(textModel().returnString(image))
                            .lineLimit(nil)
                            .fontWeight(.bold)
                            .font(.system(image.contains("Dice") ? .subheadline : .caption , design: .rounded))
                            .multilineTextAlignment(.center)
                            .lineSpacing(8)
                            .foregroundStyle(Color.white)
                    }
                    // THIRD PANEL
                    

                    
                } // HSTACK
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
                .background(
                    PanelBackgroundView(panel: image, backGroundColor: backGroundColor)
                )
            } // ZSTACK
        
    }
}


#Preview {
    
    struct Preview: View {
        
        
        @State var dicearray = Array(repeating: Dice(value: 3), count: 5)

        var body: some View {
            RowView(image: "redDice3", backGroundColor: "27ae60", dicesArray: dicearray)
                .environmentObject(ScoreBoard())
        }
    }
    return Preview()

}

