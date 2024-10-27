//
//  SecondPanelView.swift
//  Yahtzee
//

import SwiftUI

struct SecondPanelView: View {
    
    // MARK: - PROPERTIES
    let image: String
    let dicesArray: [Dice]
    
    @EnvironmentObject var scoreboard : ScoreBoard

    private let unselectPanelColor = "#d8ffb2"

    // MARK: - BODY

    var body: some View {
        
        let score = scoreModel().caculateScore(dicesArray.getDicesNumber(), image )
        let index = indexModel().returnValue(image)
        let scoreAlreadyWritten = ( scoreboard.scoresArray[ indexModel().returnValue(image) ] != nil )

        
        RoundedRectangle(cornerRadius: 10)
            .fill( scoreAlreadyWritten ? Color.white : ( scoreboard.targetArray[index] ? Color.green : Color(UIColor(hex: unselectPanelColor)) ) )
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
                            .foregroundStyle(scoreboard.targetArray[index] ? .black : .gray)
                    }
                }
                .onTapGesture {
                    if !(scoreAlreadyWritten) {
                        if scoreboard.targetArray[index] == false {
                            for i in 0 ..< scoreboard.targetArray.count {
                                scoreboard.targetArray[i] = false
                            }
                        }
                        scoreboard.targetArray[index].toggle()
                    }
                }

    }
}

#Preview {
    
    struct Preview: View {
        @State var dicearray = Array(repeating: Dice(value: 4), count: 5)

        var body: some View {
            SecondPanelView(image: "red3x", dicesArray: dicearray)
                .environmentObject(ScoreBoard())
        }
    }
    return Preview()

}
