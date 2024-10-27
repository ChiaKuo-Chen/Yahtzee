//  TextAnimateView.swift
//  Yahtzee

import SwiftUI

struct YahtzeeAnimateView: View {
    
    var duration: Double = 1
    
    // MARK: - PROPERTIES
    @State private var backgroundShow : Bool = true
    @State private var animationFirst: Bool = true
    @State private var animationSecond: Bool = false
    
    // MARK: - BODY
    
    var body: some View {
        
        
        ZStack {
            Image("yahtzee")
                .offset(x: animationFirst ? 0 : -UIScreen.main.bounds.width)
                .offset(x: animationSecond ? UIScreen.main.bounds.width : 0)
                .transition(.move(edge: .trailing))
        } // ZSTACK
        .ignoresSafeArea(.all)

        

    }

    
    
}


#Preview {
    YahtzeeAnimateView()
}
