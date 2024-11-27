//
//  ContentView.swift
//  Yahtzee
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    // MARK: - PROPERTIES
    @Query var gamedata: [GameData]
    @Environment(\.modelContext) private var modelContext

    @State var showingYahtzeeView = false
    @State var goToEndView = false

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
                    
                    ButtonView(goToYahtzeeView: $showingYahtzeeView, goToEndView: $goToEndView)
                        .padding()
                    
                } // VSTACK
                
                if showingYahtzeeView {
                    YahtzeeAnimateView(showingYahtzeeView: $showingYahtzeeView).ignoresSafeArea(.all)
                }
                
            } // ZTSACK
            .background(Color(UIColor(hex: backgroundColor)).ignoresSafeArea(.all))
            .navigationDestination(isPresented: $goToEndView){
                EndView(finalScore: gamedata[0].scoreboard[0].returnTotalScore() )
                    .modelContainer(for: GameData.self)
                    .navigationBarBackButtonHidden()
            } // GO TO ENDVIEW
        } // NAVIGATIONSTACK
        
    }
    
}

#Preview {
    ContentView()
        .modelContainer(for: GameData.self)
}
