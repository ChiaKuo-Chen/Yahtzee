//
//  ContentView.swift
//  Yahtzee
//
//  The main home screen users see after launching the app.
//  Displays player info, play button, rankings and current high score.
//  Manages CoreData and SwiftData models, syncs data with Firebase,
//  and navigates to different pages based on user interaction.
//
//  Created by 陳嘉國
//

import SwiftUI
import CoreData
import SwiftData
import FirebaseCore

struct ContentView: View {
    
    // MARK: - PROPERTIES
    
    @Environment(\.managedObjectContext) private var viewContext  // CoreData managed object context
    @FetchRequest<CorePlayer>(
        sortDescriptors: [SortDescriptor(\.localUUID)],
        animation: .default) var corePlayerData   // Fetches CorePlayer entities sorted by UUID

    // The main game data model containing dice, scores, and game state
    @Query var gamedata: [GameData]
    
    // SwiftData model context (used for saving / inserting new game data)
    @Environment(\.modelContext) private var modelContext
    
    // Object representing the "pen", i.e., which score cell the player wants to write in.
    @StateObject private var penObject = PenObject()
    
    // Navigation router
    @EnvironmentObject var router: Router
    @State var showingChangeNameView = false // Controls showing player name change popup
    @State var showingContinueView = false   // Controls showing continue game popup
    let firebasemodel = FirebaseModel()      // Firebase Firestore handler
    
    private let backgroundGradientColor = [Color.white,
                                           Color(hex: "27ae60"),
                                           Color(hex: "16a085"),
                                           Color(hex: "27ae60"),
                                           Color.green ]
    
    // MARK: - BODY
    
    var body: some View {
        
        NavigationStack(path: $router.path) {
            ZStack {
                
                // Background gradient for the home screen
                LinearGradient(colors: backgroundGradientColor, startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea(.all)
                
                VStack {
                    
                    HStack {
                        
                        // Player name display and tap to open change name view
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .font(.title)
                                .foregroundStyle(Color.yellow)
                            
                            Text(corePlayerData.first?.name ?? "Player")
                                .font(.title)
                                .fontWeight(.black)
                                .foregroundStyle(Color.white)
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .minimumScaleFactor(0.5)
                        }
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(Color.black
                            .opacity(0.4)
                            .clipShape(RoundedRectangle(cornerRadius: 8)))
                        .padding(.horizontal, 20)
                        .onTapGesture {
                            showingChangeNameView.toggle()
                        }
                        
                        Spacer()
                        
                        // Audio toggle switch if game data exists
                        if let gameData = gamedata.first {
                            AudioSwitchView(gameData: gameData)
                                .padding(.horizontal, 10)
                        }
                    }
                    .padding(.horizontal, 10)
                    
                    Spacer()
                    
                    // Yahtzee logo image
                    Image("yahtzee")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .shadow(color: Color.black, radius: 0, x:8, y:8)
                    
                    Spacer()
                    
                    // Animated big red dice for visual effect
                    DiceAnimationView()
                        .padding(.horizontal, 100)
                    
                    Spacer()
                    
                    // Play button: if previous game unfinished, show continue popup
                    Button(action: {
                        if gamedata[0].scoreboard[0].isNewGame() {
                            router.path.append(.gameTable)
                        } else {
                            showingContinueView.toggle()
                        }
                    }, label: {
                        HStack {
                            Image("whiteDiceIcon")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .padding(.horizontal, 8)
                                .shadow(color: Color.black, radius: 0, x:4, y:4)
                            
                            Text("PLAY")
                                .bold()
                                .font(.system(size: 60))
                                .fontWeight(.black)
                                .foregroundStyle(Color.white)
                                .shadow(color: Color.black, radius: 0, x:4, y:4)
                            
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                    })
                    .buttonStyle(ShadowButtonModifier())
                    
                    Spacer()
                    
                    // Rankings button: navigates to leaderboard page with player info
                    Button(action: {
                        router.path.append(.leaderboard(
                            playerName: corePlayerData.first?.name ?? "Player",
                            playerID: corePlayerData.first?.localUUID ?? UUID().uuidString,
                            playerScore: Int(corePlayerData.first?.score ?? 0),
                            playerTimeStamp: Date()))
                    }, label: {
                        HStack {
                            Image("leaderBoardIcon")
                                .resizable()
                                .frame(width: 60, height: 40)
                                .padding(.horizontal, 8)
                                .shadow(color: Color.black, radius: 0, x:2, y:2)
                            
                            Text("Rankings")
                                .bold()
                                .font(.system(size: 40))
                                .fontWeight(.black)
                                .foregroundStyle(Color.white)
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .shadow(color: Color.black, radius: 0, x:4, y:4)
                    })
                    .buttonStyle(ShadowButtonModifier())
                    
                    Spacer()
                    
                    // Display current highest score
                    Text("High Score: \(corePlayerData.first?.score ?? 0)")
                        .bold()
                        .font(.system(size: 40))
                        .fontWeight(.black)
                        .foregroundStyle(Color.white)
                        .padding(.horizontal, 28)
                        .padding(.vertical, 8)
                        .shadow(color: Color.black, radius: 0, x:4, y:4)
                    
                    Spacer()
                }
                .blur(radius: showingChangeNameView || showingContinueView ? 8 : 0)
                
                // Show Change Name popup
                if showingChangeNameView {
                    if let corePlayer = corePlayerData.first {
                        ChangeNameView(corePlayer: corePlayer, showingChangeNameView: $showingChangeNameView)
                    }
                }
                
                // Show Continue Game popup
                if showingContinueView {
                    if let gameData = gamedata.first {
                        ContinueWindowView(gameData: gameData, showingContinueView: $showingContinueView)
                    }
                }
            }
            .onAppear {
                
                // Insert initial game data if empty
                if gamedata.isEmpty {
                    modelContext.insert(generateInitialData())
                }
                
                // Insert initial player data if empty
                if corePlayerData.isEmpty {
                    let newPlayer = CorePlayer(context: viewContext)
                    newPlayer.localUUID = UUID().uuidString
                    newPlayer.name = String(format: "Player%04d", Int.random(in: 0...9999))
                    newPlayer.score = 0
                    newPlayer.timestamp = Date()
                    try? viewContext.save()
                }
                
                // Sync with Firebase if configured
                if firebasemodel.isFirebaseConfigured() {
                    firebasemodel.login()
                    
                    firebasemodel.fetchThisPlayer() { firebasePlayer in
                        
                        if let localPlayer = corePlayerData.first {
                            let localScore: Int = Int(localPlayer.score)
                            
                            // Update Firebase if local data is newer
                            firebasemodel.updatePlayerData(
                                localUUID: localPlayer.localUUID,
                                newName: (localPlayer.name != firebasePlayer?.name) ? localPlayer.name : nil,
                                newScore: (localScore > firebasePlayer?.score ?? 0) ? localScore : nil
                            )
                            
                            // Update local CoreData if Firebase has higher score
                            if firebasePlayer?.score ?? 0 > localPlayer.score {
                                corePlayerData.first?.score = Int16(firebasePlayer?.score ?? 0)
                                try? modelContext.save()
                            }
                        }
                    }
                } else {
                    print("Firebase not configured")
                }
            }
            .navigationDestination(for: Page.self) { page in
                switch page {
                case .gameTable:
                    if let gameData = gamedata.first {
                        GameTableView(gameData: gameData)
                            .environmentObject(router)
                            .environmentObject(penObject)
                            .navigationBarBackButtonHidden()
                    }
                case .end(let finalScore):
                    if let gameData = gamedata.first, let corePlayer = corePlayerData.first {
                        EndView(corePlayer: corePlayer, gameData: gameData, finalScore: finalScore)
                            .environmentObject(router)
                            .navigationBarBackButtonHidden()
                    }
                case .yahtzee:
                    YahtzeeAnimateView()
                        .environmentObject(penObject)
                        .navigationBarBackButtonHidden()
                case .leaderboard(let playerName, let playerID, let playerScore, let playerTimeStamp):
                    LeaderBoardView(playerName: playerName, playerID: playerID, playerScore: playerScore, playerTimeStamp: playerTimeStamp)
                        .environmentObject(penObject)
                        .navigationBarBackButtonHidden()
                }
            }
        }
    }
}


#Preview {
    // SwiftData
    let container = try! ModelContainer(
        for: GameData.self,
        Dice.self,
        ScoreBoard.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    let context = container.mainContext
    
    // Mock New Player
    let previewGameData = generateInitialData()
    context.insert(previewGameData)
    try? context.save()
    
    // Core Data
    let coreDataContext = PersistenceController.preview.container.viewContext
    let corePlayer = CorePlayer(context: coreDataContext)
    corePlayer.localUUID = "00000000-0000-0000-0000-000000000000"
    corePlayer.name = String(format: "Player%04d", Int.random(in: 0...9999))
    corePlayer.score = 240
    corePlayer.timestamp = Date()
    try? coreDataContext.save()
    
    return ContentView()
        .environment(\.managedObjectContext, coreDataContext) // CoreData
        .modelContainer(container)
        .environmentObject(PenObject())
        .environmentObject(Router())
}

