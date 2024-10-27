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

        case "Ones":

            Rectangle()
                .foregroundStyle(Color(UIColor(hex: backGroundColor)))
                .overlay{
                    GeometryReader { geometry in
                        Rectangle()
                            .frame(width: 6, height: geometry.size.height/2)
                            .foregroundStyle(Color.gray)
                            .offset(x: geometry.size.width/2 )
                            .offset(y: geometry.size.height/2 )
                    }
                }
            
        case "Twos", "Threes", "Fours", "Fives", "Sixes":

            Rectangle()
                .foregroundStyle(Color(UIColor(hex: backGroundColor)))
                .overlay{
                    GeometryReader { geometry in
                        Rectangle()
                            .frame(width: 6, height: geometry.size.height)
                            .foregroundStyle(Color.gray)
                            .offset(x: geometry.size.width/2 )
                    }
                }


        default:
            
            Rectangle()
                .foregroundStyle(Color(UIColor(hex: backGroundColor)))

        }
    }
}

#Preview {
    PanelBackgroundView(category: "twos", backGroundColor: "27ae60")
}
