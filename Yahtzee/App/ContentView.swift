//
//  ContentView.swift
//  Yahtzee
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    // MARK: - PROPERTIES
    @Query var gamedata: [GameData]
    
    private let backgroundColor = "043940"
    
    // MARK: - BODY
    
    var body: some View {
        
        NavigationStack{
            ZStack {
                                                
                VStack {
                    
                    ContentHeaderView()

                    BoardView()
                    
                    DiceRowView()
                        .padding()
                    
                    ButtonView()
                        .padding()
                    
                } // VSTACK
                
                
            } // ZTSACK
            .ignoresSafeArea(.all, edges: .bottom)
            .background(Color(UIColor(hex: backgroundColor)))

        } // NAVIGATIONSTACK
        
    }
    
}

#Preview {
    ContentView()
        .modelContainer(for: GameData.self)
}
