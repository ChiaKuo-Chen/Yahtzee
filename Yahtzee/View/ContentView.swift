//
//  HomeView.swift
//  Yahtzee
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    // MARK: - PROPERTIES
    @Query var gamedata: [GameData]
    @Environment(\.modelContext) private var modelContext
    @StateObject private var penObject = PenObject()
    @EnvironmentObject var router: Router
    
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
                            .padding(.horizontal)
                        
                    }
                    
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

                            Text("PLAY")
                                .bold()
                                .font(.system(size: 60))
                                .fontWeight(.black)
                                .foregroundStyle(Color.white)
                                .shadow(color: Color.black, radius: 0, x:4, y:4)
                        } // HSTACK
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.pink)
                                .shadow(color: Color.black, radius: 0, x:8, y:8)
                        )
                    } // LABEL
                    ) // BUTTON
                    
                    Spacer()
                    
                    Button(action: {
                        router.path.append(.leaderboard(playerScore: gamedata.first?.currentHighestScore ?? 0))
                    }, label: {
                        HStack {
                            HStack {
                                Image("leaderBoardIcon")
                                    .resizable()
                                    .frame(width: 60, height: 40)
                                    .padding(.horizontal, 8)

                                Text("Rankings")
                                    .bold()
                                    .font(.system(size: 40))
                                    .fontWeight(.black)
                                    .foregroundStyle(Color.white)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                            .shadow(color: Color.black, radius: 0, x:4, y:4)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.pink)
                                    .shadow(color: Color.black, radius: 0, x:8, y:8)
                            )

                        }
                    }) // BUTTON

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

                case .leaderboard(let playerScore):
                    LeaderBoardView(playerScore: playerScore)
                        .environmentObject(penObject)
                        .navigationBarBackButtonHidden()
                }
            }
            
        } // NavigationStack



    }
    
    
}

#Preview {
    
    struct Preview: View {
        let container: ModelContainer
        let context: ModelContext
        
        init() {
            container = try! ModelContainer(for: GameData.self, Dice.self, ScoreBoard.self)
            context = container.mainContext
            let previewGameData = generateInitialData()
            context.insert(previewGameData)
            try? context.save()
        }
        
        var body: some View {
            ContentView()
                .modelContainer(container)
                .environmentObject(PenObject())
                .environmentObject(Router())
        }
    }
    
    return Preview()
}
