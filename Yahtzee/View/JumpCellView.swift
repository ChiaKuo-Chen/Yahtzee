//
//  JumpCellView.swift
//  Yahtzee
//
//  Created by 陳嘉國 on 2025/8/13.
//

import SwiftUI

struct JumpCellView: View {

    // MARK: - PROPERTIES
    @State private var jumpState: Bool = false
    @State private var pulsateAnimation: Bool = false
    
    private let unselectPanelColor = "#d8ffb2"

    // MARK: - BODY
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .offset(y: 46)
                .fill(Color.brown)
                .shadow(color: .black, radius: 0, y: -46)
                .scaledToFit()
                .overlay {
                    Text("Hole")
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundStyle(.black)
                }

            RoundedRectangle(cornerRadius: 10)
                .fill(Color(UIColor(hex: unselectPanelColor)))
                .shadow(color: .gray, radius: 0, y: jumpState ? 46 : 6)
                .scaledToFit()
                .offset(y: pulsateAnimation ? -460 : 0)
                .overlay {
                    Text("Jump")
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundStyle(.black)
                        .offset(y: pulsateAnimation ? -460 : 0)
                }
        } // ZSTACK
        .animation(.bouncy(duration: 1), value: pulsateAnimation)
        .onTapGesture {
            jumpState.toggle()
            pulsateAnimation.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                jumpState.toggle()
                pulsateAnimation.toggle()
            }
        }

    }
}

#Preview {
    JumpCellView()
}
