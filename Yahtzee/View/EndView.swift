//
//  EndView.swift
//  Yahtzee
//

import SwiftUI
import SwiftData
import Vortex

struct EndView: View {
    
    // MARK: - PROPERTIES
    @Bindable var gameData: GameData
    @Environment(\.modelContext) private var modelContext

    @EnvironmentObject var router: Router

    @State private var ticketToGoBack : Bool = false
    @State private var animationSwitch : Bool = false
    @State private var highscoreUpdate : Bool = false
    @State private var renderedImage = Image(systemName: "photo")
    @Environment(\.displayScale) var displayScale

    let finalScore : Int
    private let backgroundGradientColor = [Color.white,
                                           Color(UIColor(hex: "27ae60")),
                                           Color(UIColor(hex: "16a085")),
                                           Color(UIColor(hex: "27ae60")),
                                           Color.green ]
    // MARK: - BODY
    
    var body: some View {
        
        
            ZStack {
                
                // BACKGROUND
                LinearGradient(colors: backgroundGradientColor, startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()

                VStack(alignment: .center) {
                    
                    HeaderView(gameData: gameData, showingScore: false)
                        .foregroundStyle(Color.black)

                    Image("yahtzee")
                        .scaledToFill()
                        .scaleEffect(1.6)
                        .frame(maxWidth: .infinity)
                        .shadow(color: Color.black, radius: 0, x:8, y:8)
                        .padding(.vertical, 50)
                    
                    Text("SCORE")
                        .scaleEffect(animationSwitch ? 1 : 0)
                        .animation(.spring, value: animationSwitch)
                        .font(.system (size: 30))
                        .fontWeight(.black)
                        .foregroundStyle(Color.white)
                        .shadow(color: .black ,radius: 0, x: 4, y: 4)
                    
                    Text("\(finalScore)")
                        .scaleEffect(animationSwitch ? 1 : 0)
                        .animation(.spring.delay(1), value: animationSwitch)
                        .font(.system (size: 80))
                        .fontWeight(.black)
                        .foregroundStyle(Color.white)
                        .shadow(color: .black ,radius: 0, x: 4, y: 4)


                    Text("NEW HIGH SCORE!!")
                        .scaleEffect(animationSwitch ? 1 : 0)
                        .animation(.spring.delay(2), value: animationSwitch)
                        .font(.system(size: 30))
                        .fontWeight(.black)
                        .foregroundStyle(Color.white)
                        .shadow(color: .black ,radius: 0, x: 4, y: 4)
                        .opacity(highscoreUpdate ? 1 : 0)
                        .padding()
                    
                    Spacer()
                    
                    Text(ticketToGoBack ? "PRESS TO RETURN" : "")
                        .opacity(animationSwitch ? 1 : 0)
                        .animation(.bouncy(duration: 1).repeatForever(), value: animationSwitch)
                        .font(.system(size: 30))
                        .fontWeight(.black)
                        .foregroundStyle(Color.white)
                        .shadow(color: .black ,radius: 0, x: 4, y: 4)
                        .padding(.vertical, 70)


                } // VSTACK
                
                if highscoreUpdate {
                    VortexView(.fireworks) {
                        Circle()
                            .fill(Color.white)
                            .blendMode(.plusLighter)
                            .frame(width: 32)
                            .tag("circle")
                    }
                }

            } // ZSTACK
            .onAppear{
                startAnimation()
                highscoreUpdate = ( finalScore > gameData.currentHighestScore )
            }
            .onDisappear{
                if highscoreUpdate { gameData.currentHighestScore = finalScore }
                gameData.prepareToNewPlay()
                try? modelContext.save()
            }
            .onTapGesture {
                if ticketToGoBack {
                    router.path.removeAll()
                }
            }
        
                    
    }
    
    func startAnimation() {
        animationSwitch = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 5){
            ticketToGoBack = true
        }
    }
    
}



#Preview {
    
    struct Preview: View {
        let container: ModelContainer
        let context: ModelContext
        var router = Router()
        
        init() {
            container = try! ModelContainer(for: GameData.self, Dice.self, ScoreBoard.self)
            context = container.mainContext
            let previewGameData = generateInitialData()
            context.insert(previewGameData)
            try? context.save()
            router.path.append(.end(finalScore: 83))
        }
        
        var body: some View {
            ContentView()
                .modelContainer(container)
                .environmentObject(PenObject())
                .environmentObject(router)
        }
    }
    
    return Preview()
}


