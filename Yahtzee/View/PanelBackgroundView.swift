//
//  BackGroundView.swift
//  Yahtzee

import SwiftUI

struct PanelBackgroundView: View {
    
    // MARK: - PROPERTIES
    var panel: String
    var backGroundColor: String
    
    // MARK: - BODY
    var body: some View {
        
        switch panel {

        case "redDice1":

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
            
        case "redDice2", "redDice3", "redDice4", "redDice5", "redDice6":

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
    PanelBackgroundView(panel: "redDice2", backGroundColor: "27ae60")
}
