//  TextAnimateView.swift
//  Yahtzee

import SwiftUI

struct YahtzeeAnimateView: View {
    
    // MARK: - PROPERTIES
    @State private var animationSwitch : Bool = false
    @EnvironmentObject var router: Router

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
            router.path.removeLast()
        }

    }

    
}

import SwiftData

#Preview {
    
    struct Preview: View {
        var router = Router()

        init() {
            for _ in 0...100 {
                router.path.append(.yahtzee)
            }
        }
        
        var body: some View {
            ContentView()
                .environmentObject(router)
        }
    }
    
    return Preview()
}



