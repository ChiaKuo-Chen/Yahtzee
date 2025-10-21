//
//  LoadingView.swift
//  Yahtzee
//
//  A simple loading screen displaying an animated dice with
//  a "Loading..." text that cycles dots to indicate progress.
//
//  Created by 陳嘉國
//

import SwiftUI

struct LoadingView: View {

    // MARK: - PROPERTIES
    @State private var dotCount: Int = 0  // Tracks the number of dots shown in the loading text
    let maxDots = 3                       // Maximum number of dots to cycle through
    
    // Timer that fires every 0.5 seconds to update the dotCount
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()

    // MARK: - BODY
    var body: some View {
        ZStack {
            // Semi-transparent rounded rectangle background
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(Color.black)
                .opacity(0.3)
                .frame(width: 260, height: 220)
                .offset(y: 20)

            // Loading text with animated dots
            Text("Loading " + String(repeating: ".", count: dotCount))
                .foregroundStyle(Color.black)
                .font(.title)
                .fontWeight(.heavy)
                .offset(y: 100)
                .frame(width: 140, alignment: .leading)

            // Custom dice animation view displayed above the text
            DiceAnimationView()
                .frame(width: 130)
        }
        // Update the dot count every time the timer fires, cycling from 0 to maxDots
        .onReceive(timer) { _ in
            dotCount = (dotCount + 1) % (maxDots + 1)
        }
    }
}

#Preview {
    LoadingView()
}
