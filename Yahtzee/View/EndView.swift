//
//  EndView.swift
//  Yahtzee
//
//  This is the final result screen shown after a game ends.
//  It displays:
//  - Final score with animated presentation
//  - "New High Score" indicator (if applicable)
//  - Fireworks animation using Vortex
//  - Saves data to CoreData and uploads to Firebase (if enabled)
//  - Allows player to tap anywhere to return to the main screen
//
//  Created by 陳嘉國
//

import SwiftUI
import SwiftData
import Vortex

struct EndView: View {
    
    // MARK: - PROPERTIES
    
    // CoreData context for CorePlayer saving (used with @ObservedObject)
    @Environment(\.managedObjectContext) private var viewContext
    
    // CorePlayer stores the highest score & player info (CoreData)
    @ObservedObject var corePlayer: CorePlayer
    
    // GameData model for gameplay state (SwiftData)
    @Bindable var gameData: GameData
    
    // SwiftData model context (used for saving / inserting new game data)
    @Environment(\.modelContext) private var modelContext
    
    // Navigation router
    @EnvironmentObject var router: Router

    // MARK: - STATE
    
    // Enables return to main screen after delay
    @State private var ticketToGoBack: Bool = false
    
    // Triggers score animation
    @State private var animationSwitch: Bool = false
    
    // Whether the score is a new high score
    @State private var highscoreUpdate: Bool = false
    
    // Placeholder for potential screenshot feature (unused here)
    @State private var renderedImage = Image(systemName: "photo")
    
    // Device scale (for screenshot rendering if needed)
    @Environment(\.displayScale) var displayScale
    
    // MARK: - CONSTANTS
    
    let firebasemodel = FirebaseModel()
    let finalScore: Int

    private let backgroundGradientColor = [
        Color.white,
        Color(UIColor(hex: "27ae60")),
        Color(UIColor(hex: "16a085")),
        Color(UIColor(hex: "27ae60")),
        Color.green
    ]

    // MARK: - BODY
    
    var body: some View {
        
        
        ZStack {
            
            // BACKGROUND
            LinearGradient(colors: backgroundGradientColor,
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            // FIREWORKS (only if new high score)
            if highscoreUpdate {
                VortexView(.fireworks) {
                    Circle()
                        .fill(Color.white)
                        .blendMode(.plusLighter)
                        .frame(width: 32)
                        .tag("circle")
                }
            }

            VStack(alignment: .center) {
                
                // TOP-RIGHT AUDIO SWITCH
                HStack {
                    Spacer()
                    AudioSwitchView(gameData: gameData)
                        .padding(.horizontal, 10)
                }
                
                // YAHTZEE LOGO
                Image("yahtzee")
                    .scaledToFill()
                    .scaleEffect(1.6)
                    .frame(maxWidth: .infinity)
                    .shadow(color: .black, radius: 0, x: 8, y: 8)
                    .padding(.vertical, 50)
                
                // SCORE TITLE
                Text("SCORE")
                    .scaleEffect(animationSwitch ? 1 : 0)
                    .animation(.spring, value: animationSwitch)
                    .font(.system(size: 30))
                    .fontWeight(.black)
                    .foregroundStyle(Color.white)
                    .shadow(color: .black, radius: 0, x: 4, y: 4)
                
                // FINAL SCORE
                Text("\(finalScore)")
                    .scaleEffect(animationSwitch ? 1 : 0)
                    .animation(.spring.delay(1), value: animationSwitch)
                    .font(.system(size: 80))
                    .fontWeight(.black)
                    .foregroundStyle(Color.white)
                    .shadow(color: .black, radius: 0, x: 4, y: 4)
                
                // NEW HIGH SCORE TEXT (if applicable)
                Text("NEW HIGH SCORE!!")
                    .scaleEffect(animationSwitch ? 1 : 0)
                    .animation(.spring.delay(2), value: animationSwitch)
                    .font(.system(size: 30))
                    .fontWeight(.black)
                    .foregroundStyle(Color.white)
                    .shadow(color: .black, radius: 0, x: 4, y: 4)
                    .opacity(highscoreUpdate ? 1 : 0)
                    .padding()
                
                Spacer()
                
                // TAP TO RETURN PROMPT
                Text(ticketToGoBack ? "PRESS TO RETURN" : "")
                    .opacity(animationSwitch ? 1 : 0)
                    .animation(.bouncy(duration: 1).repeatForever(), value: animationSwitch)
                    .font(.system(size: 30))
                    .fontWeight(.black)
                    .foregroundStyle(Color.white)
                    .shadow(color: .black, radius: 0, x: 4, y: 4)
                    .padding(.vertical, 70)
            } // VSTACK
        } // ZSTACK
        .onAppear{
            // Update local high score if needed
            if highscoreUpdate {
                corePlayer.score = Int16(finalScore)
            }
            
            // Always update last played time
            corePlayer.timestamp = Date()
            
            // Prepare new game state for next round
            gameData.prepareToNewPlay()
            
            try? viewContext.save()
            
            // Upload to Firebase if configured
            if highscoreUpdate && firebasemodel.isFirebaseConfigured() {
                firebasemodel.updatePlayerData(
                    localUUID: nil,
                    newName: nil,
                    newScore: finalScore
                )
            }
        }
        .onTapGesture {
            if ticketToGoBack {
                router.path.removeAll()  // Go back to main screen
            }
        }
        
    }
    
    // MARK: - FUNCTIONS
    // Triggers all animations and enables returning after delay
    func startAnimation() {
        animationSwitch = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 5){
            ticketToGoBack = true
        }
    }
    
}



#Preview {
    // Create in-memory SwiftData container for preview
    let container = try! ModelContainer(
        for: GameData.self,
        Dice.self,
        ScoreBoard.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    let context = container.mainContext

    // Insert initial game data
    let previewGameData = generateInitialData()
    context.insert(previewGameData)

    // Mock router with path to end view
    let router = Router()
    router.path.append(.end(finalScore: 136))

    try? context.save()

    // Core Data setup (for CorePlayer)
    let coreDataContext = PersistenceController.preview.container.viewContext
    let corePlayer = CorePlayer(context: coreDataContext)
    corePlayer.localUUID = "00000000-0000-0000-0000-000000000000"
    corePlayer.name = "PreviewPlayer"
    corePlayer.score = 135
    corePlayer.timestamp = Date()
    try? coreDataContext.save()

    // Return content view with environments injected
    return ContentView()
        .environment(\.managedObjectContext, coreDataContext) // CoreData
        .environmentObject(PenObject())
        .modelContainer(container)
        .environmentObject(router)
}
