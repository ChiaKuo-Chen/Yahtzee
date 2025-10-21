//
//  PanelBackgroundView.swift
//  Yahtzee
//
//  This SwiftUI view renders the background of a scoring panel (used in Yahtzee’s upper section).
//  It visually distinguishes different scoring categories (e.g., "ones", "twos", ..., "addUps")
//  using vertical gray bars as markers within the background rectangle.
//
//  Category behavior:
//  - "ones": two vertical bars, second one visible (simulates beginning of upper section)
//  - "twos" to "sixes": single vertical bar (standard mid-section appearance)
//  - "addUps": two vertical bars, first one visible (simulates end of upper section)
//  - default: plain background without markers
//
//  Created by 陳嘉國
//

import SwiftUI

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
