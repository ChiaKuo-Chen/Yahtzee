//
//  GameTableView.swift
//  Yahtzee
//
//  GamePage - The main game screen
//  Uses SwiftData to bind game data, including dice rolling, scoreboard display, and buttons.
//  Supports sound effects toggle and navigation back to the home page.
//
//  Created by 陳嘉國
//

import SwiftUI
import SwiftData

struct GameTableView: View {
    
    // MARK: - PROPERTIES
    // The main game data model containing dice, scores, and game state
    @Bindable var gameData: GameData // SwiftData bound model
    
    // SwiftData model context (used for saving / inserting new game data)
    @Environment(\.modelContext) private var modelContext
    
    // Object representing the "pen", i.e., which score cell the player wants to write in.
    @EnvironmentObject var penObject: PenObject
    
    // Router environment object for navigation control.
    @EnvironmentObject var router: Router
    
    @StateObject var audioManager = AudioManager()
    
    // Background color in hex
    private let backgroundColor = "043940"
    
    // MARK: - BODY
    
    var body: some View {
        
        
        ZStack {
            
            Color(hex: backgroundColor)
            
            VStack {
                
                HStack {
                    // Button to return to the home page by clearing navigation path
                    Button(action: {
                        router.path.removeAll()
                    }, label: {
                        Image(systemName: "house.circle")
                            .font(.system(size: 40))
                            .frame(alignment: .trailing)
                    })
                    
                    Spacer()
                    
                    // Display the total score from the scoreboard
                    Text("SCORE : \(String(gameData.scoreboard[0].returnTotalScore()))")
                            .font(.system(size: 30))
                            .fontWeight(.heavy)
                            .padding(.vertical, 10)
                        
                    Spacer()
                    
                    // Audio toggle switch for sound effects
                    AudioSwitchView(gameData: gameData)
                } // HStack
                .padding(.horizontal, 20)
                .foregroundStyle(Color.white)
                
                // Main game board showing score categories and input
                BoardView(gameData: gameData)

                // Display dice roll results
                DiceRowView(gameData: gameData)
                    .padding()
                
                // Control buttons for rolling dice, scoring, etc.
                ButtonView(viewModel: ButtonViewModel(
                    gameData: gameData,
                    modelContext: modelContext,
                    penObject: penObject,
                    router: router,
                    audioManager: audioManager
                ))
                .padding()

            } // VSTACK
        } // ZTSACK
        .ignoresSafeArea(.all)
        .onAppear{
            // Initialize audio mute state based on saved game settings
            audioManager.isMuted = !gameData.soundEffect
            // Reset pen target when view appears
            penObject.penTarget = nil
        }
        .onChange(of: gameData.soundEffect) {
            // Sync audio mute state whenever the sound effect setting changes
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
    
    context.insert(previewGameData)
    try? context.save()

    return GameTableView(gameData: previewGameData)
        .modelContainer(container)
        .environmentObject(penObject)
        .environmentObject(router)
}
