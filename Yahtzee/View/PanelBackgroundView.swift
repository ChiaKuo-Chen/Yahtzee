//
//  BackGroundView.swift
//  Yahtzee

import SwiftUI

// # - Upper section: Sum of 1s to 6s; bonus +35 if total ≥ 63
// So, Upper section, has the background which has one bar
// This view is for showing that bar, without geometry.

struct PanelBackgroundView: View {
    
    // MARK: - PROPERTIES
    var category: String
    var backGroundColor: String
    
    // MARK: - BODY
    var body: some View {
        
        switch category {

        case "ones":

            Rectangle()
                .foregroundStyle(Color(hex: backGroundColor))
                .overlay{
                    VStack {
                        Rectangle()
                            .frame(width: 6)
                            .opacity(0.0)

                        Rectangle()
                            .frame(width: 6)
                            .foregroundStyle(Color.gray)
                    }
                }
            
        case "twos", "threes", "fours", "fives", "sixes":

            Rectangle()
                .foregroundStyle(Color(hex: backGroundColor))
                .overlay{
                        Rectangle()
                            .frame(width: 6)
                            .foregroundStyle(Color.gray)
                }

        case "addUps":

            Rectangle()
                .foregroundStyle(Color(hex: backGroundColor))
                .overlay{
                    VStack {
                        Rectangle()
                            .frame(width: 6)
                            .foregroundStyle(Color.gray)

                        Rectangle()
                            .frame(width: 6)
                            .opacity(0.0)

                    }
                }

        default:
            
            Rectangle()
                .foregroundStyle(Color(hex: backGroundColor))

        }
    }
}

#Preview("one") {
    PanelBackgroundView(category: "ones", backGroundColor: "27ae60")
}

#Preview("three") {
    PanelBackgroundView(category: "threes", backGroundColor: "27ae60")
}

#Preview("other") {
    PanelBackgroundView(category: "other", backGroundColor: "27ae60")
}
