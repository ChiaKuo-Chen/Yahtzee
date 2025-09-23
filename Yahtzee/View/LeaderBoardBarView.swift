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
    
    private var scoreColor: Color {
        switch index {
        case 1: Color(uiColor: UIColor(hex: "FCEF91"))
        case 2: Color(uiColor: UIColor(hex: "F8F4E1"))
        case 3: Color(uiColor: UIColor(hex: "FAA533"))
        default: Color(uiColor: UIColor(hex: "FFD93D"))
        }
    }
    
    private var barBackgroundColor: Color {
        if index == 1 || index == 2 || index == 3 {
            return Color.blue
        } else {
            return Color(uiColor: UIColor(hex: "93DA97"))
        }
    }

    private var textColor: Color {
        switch index {
        case 1: Color(uiColor: UIColor(hex: "FCEF91"))
        case 2: Color(uiColor: UIColor(hex: "F8F4E1"))
        case 3: Color(uiColor: UIColor(hex: "FAA533"))
        default: Color.black
        }
    }
    
    private var textShadowColor: Color {
        if index == 1 || index == 2 || index == 3 {
            return Color.black
        } else {
            return Color.white
        }
    }

    
    // MARK: - BODY
    var body: some View {
        
        HStack {
            Text("\(index)")
                .foregroundStyle(textColor)
                .padding(.horizontal)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .shadow(color: textShadowColor, radius: 0, x:2, y:2)

            Text(name)
                .foregroundStyle(textColor)
                .font(.title2)
                .minimumScaleFactor(0.02)
                .multilineTextAlignment(.center)
                .fontWeight(.heavy)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .truncationMode(.tail)
                .shadow(color: textShadowColor, radius: 0, x:2, y:2)

            
            Spacer()
            
            Text("\(score)")
                .foregroundStyle(scoreColor)
                .padding(.horizontal)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .shadow(color: Color.black, radius: 0, x:2, y:2)

        } // HSTACK
        .frame(maxWidth: .infinity)
        .frame(height: 50)
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
    LeaderBoardBarView(index: 1, name: "Champion", score: 400)
}
