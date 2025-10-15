//
//  ContentView.swift
//  Yahtzee
//

import SwiftUI
import SwiftData

struct GameTableView: View {
    
    // MARK: - PROPERTIES
    @Bindable var gameData: GameData

    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var penObject: PenObject
    @EnvironmentObject var router: Router
    
    @StateObject var audioManager = AudioManager()
    
    private let backgroundColor = "043940"
    
    // MARK: - BODY
    
    var body: some View {
        
        
        ZStack {
            
            
            VStack {
                
                HStack {
                    Button(action: {
                        router.path.removeAll()
                    }, label: {
                        Image(systemName: "house.circle")
                            .font(.system(size: 40))
                            .frame(alignment: .trailing)
                    })
                    
                    Spacer()
                    
                        
                    Text("SCORE : \(String(gameData.scoreboard[0].returnTotalScore()))")
                            .font(.system(size: 30))
                            .fontWeight(.heavy)
                            .padding(.vertical, 10)
                        
                    Spacer()
                    
                    AudioSwitchView(gameData: gameData)
                }
                .foregroundStyle(Color.white)
                
                BoardView(gameData: gameData)
                
                DiceRowView(gameData: gameData)
                    .padding()
                
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
        .background(Color(hex: backgroundColor)
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
    
    context.insert(previewGameData)
    try? context.save()

    return GameTableView(gameData: previewGameData)
        .modelContainer(container)
        .environmentObject(penObject)
        .environmentObject(router)
}
