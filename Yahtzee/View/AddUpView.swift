//
//  AddUpView.swift
//  Yahtzee
//
//  This view displays the current upper section total for Yahtzee.
//  If the total of 1s–6s (addUp) is ≥ 63, a bonus of +35 points is awarded.
//  This view shows:
//  - A "Bonus +35" panel with highlighted color if bonus is achieved
//  - A circular progress meter toward 63
//
//  Created by 陳嘉國
//

import SwiftUI

struct AddUpView: View {
    
    // MARK: - PROPERTIES
    
    // Total sum of the upper section (from 1s to 6s)
    var addUp: Int
    
    // Background color (as hex string) for the progress circle
    var backGroundColor: String
    
    // MARK: - BODY
    
    var body: some View {
        
        // Determine color of the progress ring based on progress
        let addUpLineColor: Color = {
            switch addUp {
            case 0:
                return Color.gray
            case 63...:
                return Color.yellow
            default:
                return Color.white
            }
        }()
        
        // Circle stroke style
        let strokeStyle = StrokeStyle(lineWidth: 5, lineCap: .round)
        
        HStack {
            
            // BONUS TEXT PANEL (Left)
            Image("emptyPanel")
                .resizable()
                .scaledToFit()
                .overlay {
                    VStack {
                        Text("Bonus")
                            .font(.subheadline)
                        Text("+35")
                    }
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundStyle(addUp >= 63 ? Color.yellow : Color.white)
                    .shadow(color: .black, radius: 0, x: 2, y: 2)
                }
            
            // PROGRESS CIRCLE PANEL (Center)
            Image("emptyPanel")
                .resizable()
                .scaledToFit()
                .overlay {
                    ZStack {
                        // Background circle
                        Circle()
                            .fill(Color(UIColor(hex: backGroundColor)))
                            .stroke(Color.gray, style: strokeStyle)
                        
                        // Foreground progress circle
                        Circle()
                            .trim(from: 0, to: Double(addUp) / 63.0)
                            .stroke(addUpLineColor, style: strokeStyle)
                            .rotationEffect(.degrees(-85))
                            .animation(.easeInOut, value: addUp)
                        
                        // Progress Text
                        Text("\(addUp) / 63")
                            .scaledToFit()
                            .font(.caption2)
                            .fontWeight(.heavy)
                            .foregroundStyle(addUp < 63 ? Color.white : Color.yellow)
                    }
                }
            
            // EMPTY PANEL (Right) - purely decorative
            Image("emptyPanel")
                .resizable()
                .scaledToFit()
            
        } // HSTACK
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .background(
            // Apply panel background for this section
            PanelBackgroundView(category: "addUps", backGroundColor: backGroundColor)
                .ignoresSafeArea(.all)
        )
    }
}

#Preview("<63") {
    AddUpView(addUp: 43, backGroundColor: "27ae60")
}

#Preview(">=63") {
    AddUpView(addUp: 63, backGroundColor: "27ae60")
}
