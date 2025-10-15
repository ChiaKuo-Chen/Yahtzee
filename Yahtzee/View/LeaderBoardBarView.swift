//
//  LeaderBoardBarView.swift
//  Yahtzee
//
//

import SwiftUI

struct LeaderBoardBarView: View {
    
    // MARK: - PROPERTIES
    let index: Int
    let name: String
    let score: Int
    
    private var rankColor: Color {
        switch index {
        case 1: Color(hex: "FFD700")
        case 2: Color(hex: "F8F4E1")
        case 3: Color(hex: "FAA533")
        default: Color.black
        }
    }
    
    private var barBackgroundColor: Color {
        if index == 1 || index == 2 || index == 3 {
            return Color(hex: "4B0082")
        } else {
            return Color(hex: "93DA97")
        }
    }
    
    private var textShadowColor: Color {
        if index == 1 || index == 2 || index == 3 {
            return Color.black
        } else {
            return Color.white
        }
    }
    
    private var textSize: Font {
        if index == 1 || index == 2 || index == 3 {
            return .title
        } else {
            return .title2
        }
    }
    
    // MARK: - BODY
    var body: some View {
        
        HStack {
            ZStack {
                Text("\(index)")
                    .foregroundStyle(rankColor)
                    .font(textSize)
                    .fontWeight(.heavy)
                    .shadow(color: textShadowColor, radius: 0, x:2, y:2)
                
                // or whatever with .frame(minWidth: )
                Text("1234")
                    .padding(.horizontal, 8)
                    .font(.title2)
                    .opacity(0)

            } // ZSTACK

            Text(name)
                .foregroundStyle(rankColor)
                .font(textSize)
                .minimumScaleFactor(0.02)
                .multilineTextAlignment(.center)
                .fontWeight(.heavy)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .truncationMode(.tail)
                .shadow(color: textShadowColor, radius: 0, x:2, y:2)

            Spacer()
            
            ZStack {
                Text("\(score)")
                    .foregroundStyle(rankColor)
                    .padding(.horizontal)
                    .font(textSize)
                    .fontWeight(.heavy)
                    .shadow(color: textShadowColor, radius: 0, x:2, y:2)

                Text("000")
                    .padding(.horizontal)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .opacity(0)
            } // ZSTACK


        } // HSTACK
        .frame(maxWidth: .infinity)
        .frame(height: index <= 3 ? 55 : 50)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .shadow(color: Color.black, radius: 0, y: 4)
                .foregroundStyle(barBackgroundColor)
                .overlay{
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 2)
                        .foregroundStyle(Color.black)
                }
        )
        .padding(.horizontal)
    

    }

}

#Preview {
    VStack {
        LeaderBoardBarView(index: 1, name: "Champion", score: 400)
        LeaderBoardBarView(index: 2, name: "Second", score: 300)
        LeaderBoardBarView(index: 3, name: "Third", score: 200)
        LeaderBoardBarView(index: 10, name: "Number10", score: 100)
        LeaderBoardBarView(index: 999, name: "SomeGuy", score: 10)
    }
}
