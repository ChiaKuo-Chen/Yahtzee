//
//  HomeView.swift
//  Yahtzee
//

import SwiftUI
import CoreData
import SwiftData
import FirebaseCore

struct ContentView: View {
    
    // MARK: - PROPERTIES
    @Environment(\.managedObjectContext) private var viewContext     // CoreData
    @FetchRequest<CorePlayer>(
        sortDescriptors: [SortDescriptor(\.localUUID)],
        animation: .default) var corePlayerData // CoreData
    
    @Query var gamedata: [GameData] // SwiftData
    @Environment(\.modelContext) private var modelContext // SwiftData
    
    @StateObject private var penObject = PenObject()
    @EnvironmentObject var router: Router
    
    @State var showingChangeNameView = false
    @State var showingContinueView = false
    let datemodel = DateModel()
    let firebasemodel = FirebaseModel()
    private let backgroundGradientColor = [Color.white,
                                           Color(UIColor(hex: "27ae60")),
                                           Color(UIColor(hex: "16a085")),
                                           Color(UIColor(hex: "27ae60")),
                                           Color.green ]
    
    // MARK: - BODY
    
    
    var body: some View {
        
        
        NavigationStack(path: $router.path) {
            ZStack {
                
                // BACKGROUND
                LinearGradient(colors: backgroundGradientColor, startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea(.all)
                
                VStack {
                    
                    
                    HStack {
                        
                        // PLAYER NAME
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
                        } // HSTACK
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
                        
                        // Audio Switch
                        if let gameData = gamedata.first {
                            AudioSwitchView(gameData: gameData)
                        }

                    } // HSTACK
                    .padding(.horizontal, 10)

                    Spacer()
                    
                    Image("yahtzee")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .shadow(color: Color.black, radius: 0, x:8, y:8)
                    
                    Spacer()
                    
                    // That Red Big Dice
                    DiceAnimationView()
                        .padding(.horizontal, 100)
                    
                    Spacer()
                    
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
                            
                        } // HSTACK
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                    } // LABEL
                    ) // BUTTON
                    .buttonStyle(ShadowButtonModifier())
                    
                    Spacer()
                    
                    Button(action: {
                        router.path.append(.leaderboard(
                            playerName: corePlayerData.first?.name ?? "Player",
                            playerID: corePlayerData.first?.localUUID ?? UUID().uuidString,
                            playerScore: Int(corePlayerData.first?.score ?? 0),
                            playerTimeStamp: Date()))
                    }, label: {
                        HStack {
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
                        }
                    }) // BUTTON
                    .buttonStyle(ShadowButtonModifier())
                    
                    Spacer()
                    
                    Text("High Score: \(corePlayerData.first?.score ?? 0)")
                        .bold()
                        .font(.system(size: 40))
                        .fontWeight(.black)
                        .foregroundStyle(Color.white)
                        .padding(.horizontal, 28)
                        .padding(.vertical, 8)
                        .shadow(color: Color.black, radius: 0, x:4, y:4)
                    
                    Spacer()
                    
                } // VSTACK
                .blur(radius: showingChangeNameView||showingContinueView ?  8 : 0)
                
                if showingChangeNameView {
                    if let corePlayer = corePlayerData.first {
                        ChangeNameView(corePlayer: corePlayer, showingChangeNameView: $showingChangeNameView)
                    }
                }
                
                
                if showingContinueView {
                    if let gameData = gamedata.first {
                        ContinueWindowView(gameData: gameData, showingContinueView: $showingContinueView)
                    }
                }
                
            } // ZSTACK
            .onAppear{
                
                if gamedata.isEmpty {
                    modelContext.insert(generateInitialData())
                }
                
                if corePlayerData.isEmpty {
                    let newPlayer = CorePlayer(context: viewContext)
                    newPlayer.localUUID = UUID().uuidString
                    newPlayer.name = String(format: "Player%04d", Int.random(in: 0...9999))
                    newPlayer.score = 0
                    newPlayer.timestamp = Date()
                    try? viewContext.save()
                }
                
                // Fetchfrom Local Save
                if firebasemodel.isFirebaseConfigured() {
                    
                    firebasemodel.login()
                    // Firebase Login
                    
                    firebasemodel.fetchThisPlayer() { firebasePlayer in
                        
                        if let localPlayer = corePlayerData.first {
                            
                            let localScore: Int = Int(localPlayer.score)
                            
                            firebasemodel.updatePlayerData(
                                localUUID: localPlayer.localUUID,
                                newName: (localPlayer.name != firebasePlayer?.name) ? localPlayer.name : nil,
                                newScore: (localScore > firebasePlayer?.score ?? 0) ? localScore : nil
                            )
                            
                            
                            if firebasePlayer?.score ?? 0 > localPlayer.score {
                                corePlayerData.first?.score = Int16(firebasePlayer?.score ?? 0)
                                try? modelContext.save()
                            }
                        }
                        
                    }
                    // Merger Data From Local And Firebase
                    
                } else {
                    print("Firebase not configured")
                }
            } // OnAppear
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
                    if let gameData = gamedata.first, let corePlayer = corePlayerData.first  {
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
            
        } // NavigationStack
        
        
        
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

