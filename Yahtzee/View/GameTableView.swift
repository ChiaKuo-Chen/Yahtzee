//
//  ContentView.swift
//  Yahtzee
//

import SwiftUI
import SwiftData

struct GameTableView: View {
    
    // MARK: - PROPERTIES
    @Query var gamedata: [GameData]
    @Environment(\.modelContext) private var modelContext
    @StateObject var audioManager = AudioManager()

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
                    
                    ButtonView(audioManager: audioManager, goToYahtzeeView: $showingYahtzeeView, goToEndView: $goToEndView)
                        .padding()
                    
                } // VSTACK
                
                if showingYahtzeeView {
                    YahtzeeAnimateView(showingYahtzeeView: $showingYahtzeeView).ignoresSafeArea(.all)
                }
                
            } // ZTSACK
            .background(Color(UIColor(hex: backgroundColor))
                .ignoresSafeArea(.all))
            .navigationDestination(isPresented: $goToEndView){
                EndView(finalScore: gamedata[0].scoreboard[0].returnTotalScore() )
                    .modelContainer(for: GameData.self)
                    .navigationBarBackButtonHidden()
            } // GO TO ENDVIEW
        } // NAVIGATIONSTACK
        .onAppear{
            audioManager.isMuted = !gamedata[0].soundEffect
        }
        .onChange(of: gamedata[0].soundEffect) {
            audioManager.isMuted = !gamedata[0].soundEffect
        }
        
    }
    
}


#Preview {
    let container = try! ModelContainer(for: GameData.self, Dice.self, ScoreBoard.self)
    let context = container.mainContext
    let previewGameData = generateInitialData()

    context.insert(previewGameData)
    try? context.save()
    
    return GameTableView()
        .modelContainer(container)
        .environmentObject(PenObject())
}

