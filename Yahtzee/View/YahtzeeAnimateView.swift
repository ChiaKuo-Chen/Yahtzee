//
//  YahtzeeAnimateView.swift
//  Yahtzee
//
//  This view presents an animated "Yahtzee" visual as a celebration effect,
//  typically shown when five dice all showing the same number.
//
//  It scales in the image with animation, waits for 2 seconds, then dismisses itself.
//
//  Created by 陳嘉國
//

import SwiftUI

struct YahtzeeAnimateView: View {
    
    // MARK: - PROPERTIES
    
    // Controls the scaling and opacity animation of the Yahtzee image.
    @State private var animationSwitch : Bool = false
    
    // Router environment object for navigation control.
    @EnvironmentObject var router: Router

    // Gradient background.
    private let backgroundGradientColor = [Color.white,
                                           Color(UIColor(hex: "27ae60")),
                                           Color(UIColor(hex: "16a085")),
                                           Color(UIColor(hex: "27ae60")),
                                           Color.green ]
    
    // MARK: - BODY
    
    var body: some View {
        
            ZStack {
                // Background gradient for a lively celebratory feel
                LinearGradient(colors: backgroundGradientColor, startPoint: .topLeading, endPoint: .bottomTrailing)
                
                // Yahtzee image with animated scale and fade-in
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
    
    // Triggers the animation and navigates back after a delay.
    func startAnimation() {
        animationSwitch = true
        
        // Wait 2 seconds before popping the view (closing the animation screen)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            router.path.removeLast()
        }

    }

    
}

import SwiftData

#Preview {
    
    struct Preview: View {
        var router = Router()

        init() {
            // Simulate navigation stack filled with multiple paths for testing
            for _ in 0...100 {
                router.path.append(.yahtzee)
            }
        }
        
        var body: some View {
            // Render the full ContentView, which should include YahtzeeAnimateView at some point
            ContentView()
                .environmentObject(router)
        }
    }
    
    return Preview()
}



