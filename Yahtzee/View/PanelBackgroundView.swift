//
//  BackGroundView.swift
//  Yahtzee

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
                .foregroundStyle(Color(UIColor(hex: backGroundColor)))
                .overlay{
                    GeometryReader { geometry in
                        Rectangle()
                            .frame(width: 6, height: geometry.size.height/2)
                            .foregroundStyle(Color.gray)
                            .offset(x: geometry.size.width/2 - 3 )
                            .offset(y: geometry.size.height/2 )
                    }
                }
            
        case "twos", "threes", "fours", "fives", "sixes":

            Rectangle()
                .foregroundStyle(Color(UIColor(hex: backGroundColor)))
                .overlay{
                    GeometryReader { geometry in
                        Rectangle()
                            .frame(width: 6, height: geometry.size.height)
                            .foregroundStyle(Color.gray)
                            .offset(x: geometry.size.width/2 - 3 )
                    }
                }


        default:
            
            Rectangle()
                .foregroundStyle(Color(UIColor(hex: backGroundColor)))

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
