//
//  HomeView.swift
//  Yahtzee
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    // MARK: - PROPERTIES
    @Query var gamedata: [GameData]
    @Query var playerData: [PlayerData]
    @Environment(\.modelContext) private var modelContext
    @StateObject private var penObject = PenObject()
    @EnvironmentObject var router: Router
    
    @State var showingChangeNameView = false
    @State var showingContinueView = false
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
                        
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .font(.title)
                                .foregroundStyle(Color.yellow)
                            
                            Text(playerData.first?.name ?? "Player")
                                .font(.title)
                                .fontWeight(.black)
                                .foregroundStyle(Color.white)
                        } // HSTACK
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.black
                            .opacity(0.4)
                            .clipShape(RoundedRectangle(cornerRadius: 8)))
                        .padding(.horizontal, 20)
                        .onTapGesture {
                            showingChangeNameView.toggle()
                        }
                        
                        Spacer()
                        
                        // Audio Switch
                        Image(systemName: gamedata.first?.soundEffect != false ? "speaker.wave.2.circle" : "speaker.slash.circle")
                            .font(.system(size: 45, weight: .regular))
                            .foregroundStyle(Color.black)
                            .frame(alignment: .topTrailing)
                            .onTapGesture {
                                gamedata.first?.soundEffect.toggle()
                                try? modelContext.save()
                            }
                            .padding(.horizontal, 20)

                    } // HSTACK
                    
                    Spacer()
                    
                    Image("yahtzee")
                        .scaledToFit()
                        .scaleEffect(1.6)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .shadow(color: Color.black, radius: 0, x:8, y:8)
                    
                    Spacer()
                    
                    // That Red Big Dice
                    DiceAnimateView()
                    
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
                        router.path.append(.leaderboard(playerName: playerData.first?.name ?? "Player", playerID: playerData.first?.id ?? UUID(), playerScore: gamedata.first?.currentHighestScore ?? 0))
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
                    
                    Text("High Score: \(gamedata.first?.currentHighestScore ?? 0)")
                        .bold()
                        .font(.system(size: 40))
                        .fontWeight(.black)
                        .foregroundStyle(Color.white)
                        .padding(.horizontal, 28)
                        .padding(.vertical, 8)
                        .shadow(color: Color.black, radius: 0, x:4, y:4)
                    
                    Spacer()
                    
                } // VSTACK
                
                if showingChangeNameView {
                    if let playerData = playerData.first {
                        ChangeNameView(playerData: playerData, showingChangeNameView: $showingChangeNameView)
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
                
                if playerData.isEmpty {
                    let newPlayer = PlayerData()
                    modelContext.insert(newPlayer)
                }
            } // ONAPPEAR
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
                    if let gameData = gamedata.first {
                        EndView(gameData: gameData, finalScore: finalScore)
                            .environmentObject(router)
                            .navigationBarBackButtonHidden()
                    }
                case .yahtzee:
                    YahtzeeAnimateView()
                        .environmentObject(penObject)
                        .navigationBarBackButtonHidden()
                    
                case .leaderboard(let playerName, let playerID, let playerScore):
                    LeaderBoardView(playerName: playerName, playerID: playerID, playerScore: playerScore)
                        .environmentObject(penObject)
                        .navigationBarBackButtonHidden()
                }
            }
            
        } // NavigationStack
        
        
        
    }
    
    
}

#Preview {
    let container = try! ModelContainer(
        for: GameData.self,
        Dice.self,
        ScoreBoard.self,
        PlayerData.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    let context = container.mainContext
    
    let previewGameData = generateInitialData()
    context.insert(previewGameData)
    
    let testPlayer = PlayerData()
    context.insert(testPlayer)
    
    
    try? context.save()
    
    return ContentView()
        .modelContainer(container)
        .environmentObject(PenObject())
        .environmentObject(Router())
}

