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
    
    @State var showingContinueView = false
    @State var goToContentView : Bool = false
    private let backgroundGradientColor = [Color.white,
                                           Color(UIColor(hex: "27ae60")),
                                           Color(UIColor(hex: "16a085")),
                                           Color(UIColor(hex: "27ae60")),
                                           Color.green ]
    
    // MARK: - BODY
    
    
    var body: some View {
        
        
        NavigationStack {
            ZStack {
                
                LinearGradient(colors: backgroundGradientColor, startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea(.all)

                VStack {
                    
                    HStack {    
                                                
                        Spacer()

                        Image(systemName: gamedata.first?.soundEffect != false ? "speaker.wave.2.circle" : "speaker.slash.circle")
                            .font(.system(size: 45, weight: .regular))
                            .foregroundStyle(Color.black)
                            .frame(alignment: .topTrailing)
                            .onTapGesture {
                                gamedata.first?.soundEffect.toggle()
                                try? modelContext.save()
                            }
                            .padding()

                    }
                    
                    Spacer()
                    
                    Image("yahtzee")
                        .scaledToFit()
                        .scaleEffect(1.6)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .shadow(color: Color.black, radius: 0, x:8, y:8)
                    
                    Spacer()
                    
                    DiceAnimateView()
                    
                    Spacer()
                    
                    Button(action: {
                        if gamedata[0].scoreboard[0].isNewGame() {
                            goToContentView = true
                        } else {
                            showingContinueView.toggle()
                        }
                    }, label: {
                        Text("PLAY")
                            .bold()
                            .font(.system(size: 60))
                            .fontWeight(.black)
                            .foregroundStyle(Color.white)
                            .padding(.horizontal, 28)
                            .padding(.vertical, 8)
                            .shadow(color: Color.black, radius: 0, x:4, y:4)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.pink)
                                    .shadow(color: Color.black, radius: 0, x:8, y:8)
                            )
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
                    ContinueWindowView(showingContinueView: $showingContinueView, goToContentView: $goToContentView)
                }
            } // ZSTACK
            .onAppear{
                if gamedata.isEmpty {
                    modelContext.insert(generateInitialData())
                }
            } // ONAPPEAR
            .navigationDestination(isPresented: $goToContentView){
                GameTableView()
                    .modelContainer(for: GameData.self)
                    .environmentObject(PenObject())
                    .navigationBarBackButtonHidden()
            } // GO TO YahtzeeAnimateView

        } // NavigationStack
        
        
    }
    

}

#Preview {
    ContentView()
        .modelContainer(for: GameData.self)
}
