//
//  ContentView.swift
//  Yahtzee
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    // MARK: - PROPERTIES
    @Query var gamedata: [GameData]
    
    @State var dicesArray = Array(repeating: Dice(), count: 5)
    @State var rollCount = 3
    
    private let backgroundColor = "043940"
    
    // MARK: - BODY
    
    var body: some View {
        
        NavigationStack{
            ZStack {
                                                
                VStack {
                    
                    HeaderView()

                    BoardView(dicesArray: $dicesArray)
                    
                    DiceRowView(dicesArray: $dicesArray)
                        .padding()
                    
                    ButtonView(dicesArray: $dicesArray, rollCount: $rollCount)
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
