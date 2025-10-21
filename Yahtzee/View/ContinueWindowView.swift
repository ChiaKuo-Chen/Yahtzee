//
//  ContinueWindowView.swift
//  Yahtzee
//
//  Continue dialog that lets user choose between continuing previous game or starting a new one.
//
//  Created by 陳嘉國
//

import SwiftUI
import SwiftData

struct ContinueWindowView: View {
    
    // MARK: - PROPERTIES
    @Bindable var gameData: GameData

    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var router: Router

    @Binding var showingContinueView: Bool  // Controls visibility of this dialog
    @State var startAnimation : Bool = false
    
    // MARK: - BODY
    
    var body: some View {
                    
            ZStack {
                
                // Background overlay to block interactions and dismiss on tap outside window
                Color.gray.opacity(0.3)
                    .onTapGesture {
                        showingContinueView.toggle()
                    }
                
                VStack(spacing: 0) {
                    
                    // Title bar with dismiss button
                    Text("CONTINUE?")
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(Color.orange)
                        .overlay{
                        
                            HStack {
                                Spacer()
                                
                                // Dismiss Button (Dismiss this entire Window.)
                                Button(action: {
                                    self.showingContinueView.toggle()
                                }, label: {
                                    Rectangle()
                                        .aspectRatio(1.0, contentMode: .fit)
                                        .foregroundStyle(Color.red)
                                        .font(.largeTitle)
                                        .border(Color.white, width: 2)
                                        .padding()
                                        .overlay{
                                            Text("X")
                                                .font(.title3)
                                                .fontWeight(.black)
                                                .foregroundStyle(Color.white)
                                        }

                                }) // BUTTON TO DISMISS THE WINDOW
                            } // HSTACK

                        }

                    Text(
"""
Would you like to continue your previous game or start a new one?
""")
                    .multilineTextAlignment(.center)
                    .font(.title3)
                    .fontWeight(.black)
                    .foregroundColor(Color.brown)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)

                    // Buttons for New Game and Continue
                    HStack {
                        newGameButton
                        continueGameButton
                    } // HSTACK
                    .padding()
                    .background(Color.white)
                    .fixedSize(horizontal: false, vertical: true)

                } // VSTACK
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .padding(.horizontal, 40)
                .scaleEffect(startAnimation ? 1 : 0)
                .animation(.spring, value: startAnimation)
                .onAppear{
                    startAnimation.toggle()
                }
                            
            } //ZSTACK
            .ignoresSafeArea(.all)

    }
    
    // MARK: BUTTONS
    
    var newGameButton: some View {
        Button {
            // Prepare new game data, save, dismiss dialog, navigate to game
            gameData.prepareToNewPlay()
            try? modelContext.save()
            // Dismiss this window
            self.showingContinueView.toggle()
            // Go to the Gamepage
            router.path.append(.gameTable)
        } label: {
            Text("NEW GAME")
                .font(.headline)
                .fontWeight(.black)
                .foregroundStyle(Color.white)
                .padding()
                .lineLimit(1)
                .frame(maxWidth: .infinity)
                .background(Color.orange)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(color: Color.gray ,radius: 4, x: 0, y: 4)
        }
    }

    var continueGameButton: some View {
        Button {
            // Dismiss dialog and navigate to game with current data
            self.showingContinueView.toggle()
            router.path.append(.gameTable)
        } label: {
            Text("CONTINUE")
                .font(.headline)
                .fontWeight(.black)
                .foregroundStyle(Color.white)
                .padding()
                .lineLimit(1)
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(color: Color.gray ,radius: 4, x: 0, y: 4)
        }
    }

}

#Preview {
    struct Preview: View {
        @State var showingContinueView = true
        @StateObject var router = Router()

        var body: some View {
            let initialScoreBoard = [ScoreBoard()]
            let initialDiceArray = [
                Dice(value: 1, isHeld: false, isRoll: 0),
                Dice(value: 2, isHeld: false, isRoll: 0),
                Dice(value: 3, isHeld: false, isRoll: 0),
                Dice(value: 4, isHeld: false, isRoll: 0),
                Dice(value: 5, isHeld: false, isRoll: 0),
            ]
            let gameData = GameData(
                soundEffect: true,
                scoreboard: initialScoreBoard,
                diceArray: initialDiceArray
            )

            ContinueWindowView(
                gameData: gameData,
                showingContinueView: $showingContinueView
            )
            .environmentObject(router)
        }
    }

    return Preview()
}
