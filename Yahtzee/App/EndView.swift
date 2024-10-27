//
//  EndView.swift
//  Yahtzee
//

import SwiftUI
import SwiftData

struct EndView: View {
    
    // MARK: - PROPERTIES
    @Query var gameData: [GameSettingsData]
    
    var finalScore : Int
    private let backgroundGradientColor = [Color.white,
                                           Color(UIColor(hex: "27ae60")),
                                           Color(UIColor(hex: "16a085")),
                                           Color(UIColor(hex: "27ae60")),
                                           Color.green ]
    
    // MARK: - BODY
    
    var body: some View {
        
        let highscoreUpdate = ( finalScore > gameData[0].currentHighestScore )
        if highscoreUpdate {
            let _ = ( gameData.first?.newHighestScore = finalScore )
        }
        
        NavigationStack {
            
            ZStack {
                

                VStack(alignment: .center) {
                    
                        
                    HStack {
                        
                        Spacer()
                        
                        Image(systemName: gameData.first?.soundEffect != false ? "speaker.wave.2.circle" : "speaker.slash.circle")
                                .font(.system(size: 45))
                                .foregroundStyle(Color.white)
                                .frame(alignment: .trailing)
                                .onTapGesture {
                                    gameData.first?.soundEffect.toggle()
                                }
                                .padding()
                                .frame(alignment: .topTrailing)
                    }
                    
                    Image("yahtzee")
                        .scaledToFill()
                        .scaleEffect(1.6)
                        .frame(maxWidth: .infinity)
                        .shadow(color: Color.black, radius: 0, x:8, y:8)
                        .padding(.vertical, 50)
                    Text("SCORE")
                        .font(.system (size: 30))
                        .fontWeight(.black)
                        .foregroundStyle(Color.white)
                        .shadow(color: .black ,radius: 0, x: 4, y: 4)
                    Text("\(finalScore)")
                        .font(.system (size: 80))
                        .fontWeight(.black)
                        .foregroundStyle(Color.white)
                        .shadow(color: .black ,radius: 0, x: 4, y: 4)


                    Text("NEW HIGH SCORE!!")
                        .font(.system(size: 30))
                        .fontWeight(.black)
                        .foregroundStyle(Color.white)
                        .shadow(color: .black ,radius: 0, x: 4, y: 4)
                        .padding()
                        .opacity(highscoreUpdate ? 1 : 0)
                    
                    Spacer()

                } // VSTACK
                .ignoresSafeArea(.all)
                
            }
            .background(
                LinearGradient(colors: backgroundGradientColor, startPoint: .topLeading, endPoint: .bottomTrailing)
            )


        } // NavigationStack
        
    }
}

#Preview {
    EndView(finalScore: 60)
        .modelContainer(for: GameSettingsData.self)
}
