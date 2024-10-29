//  TextAnimateView.swift
//  Yahtzee

import SwiftUI

struct YahtzeeAnimateView: View {
    
    // MARK: - PROPERTIES
    @State private var animationSwitch : Bool = false
    @State private var goBackToContenView : Bool = false
    private let backgroundGradientColor = [Color.white,
                                           Color(UIColor(hex: "27ae60")),
                                           Color(UIColor(hex: "16a085")),
                                           Color(UIColor(hex: "27ae60")),
                                           Color.green ]
    
    // MARK: - BODY
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                
                LinearGradient(colors: backgroundGradientColor, startPoint: .topLeading, endPoint: .bottomTrailing)
                
                
                Image("yahtzee")
                    .scaleEffect(animationSwitch ? 1.7 : 0.8)
                    .opacity(animationSwitch ? 1 : 0)
                    .shadow(color: .black, radius: 0, x: 8, y: 8)
                    .animation(.easeInOut(duration: 1), value: animationSwitch)
                
            } // ZSTACK
            .ignoresSafeArea(.all)
            .navigationDestination(isPresented: $goBackToContenView){
                ContentView()
                    .modelContainer(for: GameData.self)
                    .navigationBarBackButtonHidden()
                
            } // GO TO ContentView
        } // NAVIGATION STACK
        
        let _ = DispatchQueue.main.asyncAfter(deadline: .now() + 0){
            animationSwitch = true
        }
        
        let _ = DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            goBackToContenView = true
        }
        
        
    }
    
    
    
}


#Preview {
    YahtzeeAnimateView()
}
