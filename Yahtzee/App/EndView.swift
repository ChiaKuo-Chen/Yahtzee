//
//  EndView.swift
//  Yahtzee
//

import SwiftUI
import SwiftData

struct EndView: View {
    
    // MARK: - PROPERTIES
    @Query var gamedata: [GameData]
    @Environment(\.modelContext) private var modelContext

    @State private var goBackToCoverView : Bool = false
    @State private var ticketToGoBack : Bool = false
    @State private var animationSwitch : Bool = false
    @State private var highscoreUpdate : Bool = false

    let finalScore : Int
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

                VStack(alignment: .center) {
                    
                    EndHeaderView()
                    
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
                
            } // ZSTACK
            .ignoresSafeArea()
            .onAppear{
                startAnimation()
                highscoreUpdate = ( finalScore > gamedata[0].currentHighestScore )
            }
            .onDisappear{
                if highscoreUpdate { gamedata[0].currentHighestScore = finalScore }
                gamedata[0].prepareToNewPlay()
                try? modelContext.save()
            }
            .onTapGesture {
                if ticketToGoBack {
                    goBackToCoverView.toggle()
                }
            }
            .navigationDestination(isPresented: $goBackToCoverView){
                CoverView()
                    .modelContainer(for: GameData.self)
                    .navigationBarBackButtonHidden()
            } // GO TO ContentView
            
        } // NavigationStack
        
    }
    
    func startAnimation() {
        animationSwitch = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 5){
            ticketToGoBack = true
        }
    }
    
}

#Preview {
    EndView(finalScore: 230)
        .modelContainer(for: GameData.self)
}
