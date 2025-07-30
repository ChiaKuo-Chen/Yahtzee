//
//  AddUpView.swift
//  Yahtzee
//

import SwiftUI

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
            
            ZStack {
                Image("emptyPanel")
                    .resizable()
                    .scaledToFit()
                
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

            
            ZStack {
                
                
                Circle()
                    .fill( Color(UIColor(hex: backGroundColor)) )
                    .stroke(Color.gray, style: strokeStyle)
                    .overlay{
                        GeometryReader { geometry in
                            Rectangle()
                                .frame(width: 6, height: geometry.size.height/4)
                                .foregroundStyle(Color.gray)
                                .offset(x: geometry.size.width/2 )
                                .offset(y: -geometry.size.height/4 )
                        }
                    }

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
            
            Image("emptyPanel")
                .resizable()
                .scaledToFit()

        } // HSTACK
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .background(
            Color(UIColor(hex: backGroundColor))
        )


    }
}

#Preview {
    AddUpView(addUp: 43, backGroundColor: "27ae60")
}

#Preview(">=63") {
    AddUpView(addUp: 63, backGroundColor: "27ae60")
}
