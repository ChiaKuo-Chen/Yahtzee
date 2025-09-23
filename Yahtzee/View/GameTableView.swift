//
//  ContentView.swift
//  Yahtzee
//

import SwiftUI
import SwiftData

struct GameTableView: View {
    
    // MARK: - PROPERTIES
    @Bindable var gameData: GameData
    @Bindable var playerData: PlayerData

    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var penObject: PenObject
    @EnvironmentObject var router: Router
    
    @StateObject var audioManager = AudioManager()
    
    private let backgroundColor = "043940"
    
    // MARK: - BODY
    
    var body: some View {
        
        
        ZStack {
            
            
            VStack {
                
                HeaderView(gameData: gameData, showingScore: true)
                    .foregroundStyle(Color.white)
                
                BoardView(gameData: gameData)
                
                DiceRowView(gameData: gameData)
                    .padding()
                
                ButtonView(viewModel: ButtonViewModel(
                    playerData: playerData,
                    gameData: gameData,
                    modelContext: modelContext,
                    penObject: penObject,
                    router: router,
                    audioManager: audioManager
                ))
                .padding()

            } // VSTACK
                        
        } // ZTSACK
        .background(Color(UIColor(hex: backgroundColor))
            .ignoresSafeArea(.all))
        .onAppear{
            audioManager.isMuted = !gameData.soundEffect
            penObject.penTarget = nil
            
        }
        .onChange(of: gameData.soundEffect) {
            audioManager.isMuted = !gameData.soundEffect
        }
        
    }
    
}

#Preview {
    
    let container = try! ModelContainer(for: GameData.self, Dice.self, ScoreBoard.self)
    let context = container.mainContext
    let previewGameData = generateInitialData()
    let penObject = PenObject()
    let router = Router()
    let playerData = PlayerData(id: "00000000-0000-0000-0000-000000000000", name: "TestPlayer")
    
    context.insert(previewGameData)
    try? context.save()

    return GameTableView(gameData: previewGameData, playerData: playerData)
        .modelContainer(container)
        .environmentObject(penObject)
        .environmentObject(router)
}
