//
//  HomeView.swift
//  Yahtzee
//

import SwiftUI
import SwiftData

struct CoverView: View {
    
    // MARK: - PROPERTIES
    @Environment(\.modelContext) private var modelContext
    @Query var gamedata: [GameData]
        
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
                
                VStack {
                    
                    
                    HStack {
                        
                        Image(systemName: "minus.circle")
                            .font(.system(size: 45))
                            .foregroundStyle(Color.white)
                            .frame(alignment: .trailing)
                            .onTapGesture {
                                modelContext.delete(gamedata[0])
                                modelContext.insert(generateInitialData())
                            }
                            .padding()

                        Spacer()
                        
                        // BUTTON FOR DELETE SWIFT DATA
                        // ONLY USE FOR TEST
                        Image(systemName: gamedata.first?.soundEffect != false ? "speaker.wave.2.circle" : "speaker.slash.circle")
                            .font(.system(size: 45, weight: .regular))
                            .foregroundStyle(Color.black)
                            .frame(alignment: .topTrailing)
                            .onTapGesture {
                                gamedata.first?.soundEffect.toggle()
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
                    
                    NavigationLink(destination: {
                        ContentView()
                            .modelContainer(for: GameData.self)
                            .navigationBarBackButtonHidden()
                        
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
                    }) // NAVIGATIONLINK
                    
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
            } // ZSTACK
            .ignoresSafeArea(.all)
            .onAppear{                
                if gamedata.isEmpty {
                    modelContext.insert(generateInitialData())
                } else {
                    let _ = ( gamedata[0].currentHighestScore = gamedata[0].newHighestScore )
                }
            } // ONAPPEAR
        } // NavigationStack
        
        
    }
    
    
}

#Preview {
    CoverView()
        .modelContainer(for: GameData.self)
    
}
