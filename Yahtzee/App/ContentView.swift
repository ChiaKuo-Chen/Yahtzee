//
//  ContentView.swift
//  Yahtzee
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    // MARK: - PROPERTIES
    @Query var gameData: [GameSettingsData]
    @EnvironmentObject var scoreboard : ScoreBoard
    
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
                
                if scoreModel().caculateScore(dicesArray.getDicesNumber(), "yahtzee") == 50 {
                    YahtzeeAnimateView()
                        .shadow(color: .black, radius: 0, x: 8, y: 8)
                        .scaleEffect(1.7)
                } // SPECIAL ANIMATION FOR YAHTZEE
                
            } // ZTSACK
            .ignoresSafeArea(.all, edges: .bottom)
            .background(Color(UIColor(hex: backgroundColor)))
            
        } // NAVIGATIONSTACKl
        
        
    }
    
}

#Preview {
    ContentView()
        .environmentObject(ScoreBoard())
        .modelContainer(for: GameSettingsData.self)
}
