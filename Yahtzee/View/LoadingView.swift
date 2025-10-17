//
//  LoadingView.swift
//  Yahtzee
//
//  Created by 陳嘉國
//

import SwiftUI

struct LoadingView: View {

    // MARK: - PROPERTIES
    @State private var dotCount: Int = 0
    let maxDots = 3
    
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()

    // MARK: - BODY
    var body: some View {
        ZStack {

            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(Color.black)
                .opacity(0.3)
                .frame(width: 260, height: 220)
                .offset(y: 20)

            Text("Loading " + String(repeating: ".", count: dotCount))
                .foregroundStyle(Color.black)
                .font(.title)
                .fontWeight(.heavy)
                .offset(y: 100)
                .frame(width: 140, alignment: .leading)

            DiceAnimationView()
                .frame(width: 130)

        }
        .onReceive(timer) { _ in
            dotCount = (dotCount + 1) % (maxDots + 1)
        }
    }
}

#Preview {
    LoadingView()
}
