//
//  EndView.swift
//  Yahtzee
//

import SwiftUI
import SwiftData
import Vortex

struct EndView: View {
    
    // MARK: - PROPERTIES
    @Environment(\.managedObjectContext) private var viewContext     // CoreData
    @ObservedObject var corePlayer: CorePlayer // CoreData

    @Bindable var gameData: GameData

    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var router: Router
    
    @State private var ticketToGoBack : Bool = false
    @State private var animationSwitch : Bool = false
    @State private var highscoreUpdate : Bool = false
    @State private var renderedImage = Image(systemName: "photo")
    @Environment(\.displayScale) var displayScale
    
    let firebasemodel = FirebaseModel()
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
                
                HStack {
                    Spacer()
                    
                    Image(systemName: gameData.soundEffect != false ? "speaker.wave.2.circle" : "speaker.slash.circle")
                        .font(.system(size: 30))
                        .onTapGesture {
                            gameData.soundEffect.toggle()
                            try? modelContext.save()
                        }
                        .foregroundStyle(Color.black)
                        .padding(.horizontal, 20)
                }
                
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
            highscoreUpdate = ( finalScore > corePlayer.score )
            
            if highscoreUpdate {
                corePlayer.score = Int16(finalScore)
            }
            corePlayer.timestamp = Date()
            gameData.prepareToNewPlay()
            try? viewContext.save()

            if highscoreUpdate && firebasemodel.isFirebaseConfigured() {
                firebasemodel.updatePlayerData(localUUID: nil, newName: nil, newScore: finalScore)
            }
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

    let container = try! ModelContainer(
        for: GameData.self,
        Dice.self,
        ScoreBoard.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    let context = container.mainContext
    
    let previewGameData = generateInitialData()
    context.insert(previewGameData)
        
    let router = Router()
    router.path.append(.end(finalScore: 136))

    try? context.save()
    
    // Core Data
    let coreDataContext = PersistenceController.preview.container.viewContext
    let corePlayer = CorePlayer(context: coreDataContext)
    corePlayer.localUUID = "00000000-0000-0000-0000-000000000000"
    corePlayer.name = "PreviewPlayer"
    corePlayer.score = 135
    corePlayer.timestamp = Date()
    try? coreDataContext.save()

    return ContentView()
        .environment(\.managedObjectContext, coreDataContext) // CoreData
        .environmentObject(PenObject())
        .modelContainer(container)
        .environmentObject(router)
    
}

