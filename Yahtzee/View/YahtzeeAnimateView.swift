//  TextAnimateView.swift
//  Yahtzee

import SwiftUI

struct YahtzeeAnimateView: View {
    
    // MARK: - PROPERTIES
    @State private var animationSwitch : Bool = false
    @Binding var showingYahtzeeView : Bool
    
    private let backgroundGradientColor = [Color.white,
                                           Color(UIColor(hex: "27ae60")),
                                           Color(UIColor(hex: "16a085")),
                                           Color(UIColor(hex: "27ae60")),
                                           Color.green ]
    
    // MARK: - BODY
    
    var body: some View {
        
            ZStack {
                
                LinearGradient(colors: backgroundGradientColor, startPoint: .topLeading, endPoint: .bottomTrailing)
                
                
                Image("yahtzee")
                    .scaleEffect(animationSwitch ? 1.7 : 0.8)
                    .opacity(animationSwitch ? 1 : 0)
                    .shadow(color: .black, radius: 0, x: 8, y: 8)
                    .animation(.easeInOut(duration: 1), value: animationSwitch)
                
            } // ZSTACK
            .ignoresSafeArea(.all)
            .onAppear{
                startAnimation()
            }
        
    }
    
    func startAnimation() {
        animationSwitch = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            showingYahtzeeView = false
        }

    }

    
}


#Preview {
    struct Preview: View {
        
        @State private var showingYahtzeeView: Bool = true

        var body: some View {
            YahtzeeAnimateView(showingYahtzeeView: $showingYahtzeeView)
        }
    }
    return Preview()

}
