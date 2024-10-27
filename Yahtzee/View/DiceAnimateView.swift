//
//  DiceAnimateView.swift
//  Yahtzee
//

import SwiftUI

struct DiceAnimateView: View {

    // MARK: - PROPERTIES
    @State private var pulsateAnimation: Bool = false

    // MARK: - BODY

    var body: some View {
        
        ZStack {
            Image("bigRedDice")
                .scaledToFit()
                .rotationEffect(.degrees(pulsateAnimation ? -10 : 10))
                .animation(.easeInOut(duration: 3).repeatForever(), value: pulsateAnimation)
        }
        
        let _ = DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            pulsateAnimation = true
        }

    }
}

#Preview {
    DiceAnimateView()
}
