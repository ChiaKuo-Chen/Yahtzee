//
//  LeaderBoardBarView.swift
//  Yahtzee
//
//  View to display a leaderboard entry with rank, player name, and score.
//  Highlights top 3 ranks with special colors, sizes, and styling for emphasis.
//  Designed to adapt appearance dynamically based on rankIndex.
//
//  Supports truncation and scaling for long names and scores, ensuring readability.
//
//  Created by 陳嘉國
//

import SwiftUI

struct LeaderBoardBarView: View {
    
    // MARK: - PROPERTIES
    let rankIndex: Int // 1 = Champion, 2 = runner up, 3 = third place
    let name: String
    let score: Int
    
    // Special Color For Top3
    private var rankColor: Color {
        switch rankIndex {
        case 1: Color(hex: "FFD700")
        case 2: Color(hex: "F8F4E1")
        case 3: Color(hex: "FAA533")
        default: Color.black
        }
    }
    
    // Special Color For Top3 background
    private var barBackgroundColor: Color {
        if rankIndex == 1 || rankIndex == 2 || rankIndex == 3 {
            return Color(hex: "4B0082")
        } else {
            return Color(hex: "93DA97")
        }
    }
    
    // Text shadow color based on rank for better contrast
    private var textShadowColor: Color {
        if rankIndex == 1 || rankIndex == 2 || rankIndex == 3 {
            return Color.black
        } else {
            return Color.white
        }
    }

    // Font size changes slightly for top 3 ranks
    private var textSize: Font {
        if rankIndex == 1 || rankIndex == 2 || rankIndex == 3 {
            return .title
        } else {
            return .title2
        }
    }
    
    // MARK: - BODY
    var body: some View {
        
        HStack {
            ZStack {
                Text("\(rankIndex)")
                    .foregroundStyle(rankColor)
                    .font(textSize)
                    .fontWeight(.heavy)
                    .shadow(color: textShadowColor, radius: 0, x:2, y:2)
                
                // Invisible text for minimum width alignment
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

                // Invisible text to reserve space for consistent layout
                Text("000")
                    .padding(.horizontal)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .opacity(0)
            } // ZSTACK


        } // HSTACK
        .frame(maxWidth: .infinity)
        .frame(height: rankIndex <= 3 ? 55 : 50)
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
        LeaderBoardBarView(rankIndex: 1, name: "Champion", score: 400)
        LeaderBoardBarView(rankIndex: 2, name: "Second", score: 300)
        LeaderBoardBarView(rankIndex: 3, name: "Third", score: 200)
        LeaderBoardBarView(rankIndex: 10, name: "Number10", score: 100)
        LeaderBoardBarView(rankIndex: 999, name: "SomeGuy", score: 10)
    }
}
