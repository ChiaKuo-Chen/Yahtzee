//
//  AddUpView.swift
//  Yahtzee
//

import SwiftUI

// This one is for the yathzee rule.
// # - Upper section: Sum of 1s to 6s; bonus +35 if total ≥ 63

struct AddUpView: View {
    
    // MARK: - PROPERTIES
    var addUp: Int
    var backGroundColor: String
    
    // MARK: - BODY
    
    var body: some View {
        
        let addUpLineColor: Color = {
            switch (addUp) {
            case 0: return Color.gray
            case 63...: return Color.yellow
            default: return Color.white
            }
        }()
        
        let strokeStyle = StrokeStyle(lineWidth: 5, lineCap: .round)
        
        HStack {
            
            Image("emptyPanel")
                .resizable()
                .scaledToFit()
                .overlay{
                    VStack {
                        Text("Bonus")
                            .font(.subheadline)
                        Text("+35")
                    }
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundStyle(addUp>=63 ? Color.yellow : Color.white)
                    .shadow(color: .black,radius: 0, x: 2, y: 2)
                }
            
            Image("emptyPanel")
                .resizable()
                .scaledToFit()
                .overlay{
                    ZStack {
                        Circle()
                            .fill( Color(UIColor(hex: backGroundColor)) )
                            .stroke(Color.gray, style: strokeStyle)
                        
                        Circle()
                            .trim(from: 0, to: ( Double(addUp) / 63.0 ) )
                            .stroke(addUpLineColor, style: strokeStyle)
                            .rotationEffect(.degrees(-85))
                            .animation(.easeInOut, value: addUp)
                        
                        Text("\(addUp) / 63")
                            .scaledToFit()
                            .font(.caption2)
                            .fontWeight(.heavy)
                            .foregroundStyle(addUp<63 ? Color.white : Color.yellow)
                    } // ZSTACK
                }
            
            
            Image("emptyPanel")
                .resizable()
                .scaledToFit()
            
        } // HSTACK
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .background(
            PanelBackgroundView(category: "addUps", backGroundColor: backGroundColor)
                .ignoresSafeArea(.all)
        )
        
        
        
    }
}

#Preview {
    AddUpView(addUp: 43, backGroundColor: "27ae60")
}

#Preview(">=63") {
    AddUpView(addUp: 63, backGroundColor: "27ae60")
}
