//
//  ButtonView.swift
//  Yahtzee
//

import SwiftUI
import SwiftData

struct ButtonView: View {
    
    // MARK: - PROPERTIES
    @Query var gamedata: [GameData]
    
    @Binding var dicesArray: [Dice]
    @Binding var rollCount : Int
    
    @State private var goToEndView = false
    let scoremodel = ScoreModel()
    
    // MARK: - BODY
    
    var body: some View {
        
        NavigationStack {
            HStack {
                // ROLL BUTTON
                Button(action: {
                    
                    if rollCount > 0 && dicesArray.getDicesHeld().filter({$0 == true}).count < 5 {
                        
                        if gamedata.first?.soundEffect == true {
                            playSound(sound: "diceRoll", type: "mp3")
                        }
                        
                        for item in 0 ..< dicesArray.count {
                            dicesArray[item].roll()
                        }
                        rollCount -= 1
                        
                    }
                }, // ACTION
                       label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(Color.yellow)
                            .fontWeight(.bold)
                            .frame(maxHeight: 60)
                            .frame(maxWidth: .infinity)
                            .shadow(color: .black, radius: 0, x: 2, y: 2)
                        
                        HStack {
                            Text("ROLL")
                                .bold()
                                .foregroundStyle(Color.black)
                            Circle()
                                .scaledToFit()
                                .frame(maxWidth: 25)
                                .foregroundStyle(rollCount > 0 ? Color.green : Color.gray)
                            Circle()
                                .scaledToFit()
                                .frame(maxWidth: 25)
                                .foregroundStyle(rollCount > 1 ? Color.green : Color.gray)
                            Circle()
                                .scaledToFit()
                                .frame(maxWidth: 25)
                                .foregroundStyle(rollCount > 2 ? Color.green : Color.gray)
                            
                        } // HSTACK
                    } // ZSTACK
                } // LABEL
                ) // ROLL BUTTON
                
                // PLAY BUTTON
                if rollCount < 3 {
                    Button(action: {
                        
                        if gamedata[0].scoreboard[0].penTarget != nil {
                            
                            
                            if let penIndex = gamedata[0].scoreboard[0].penTarget {
                                
                                gamedata[0].scoreboard[0].updateScoreBoard(newScore: scoremodel.caculateScore(dicesArray, index: penIndex), penIndex: penIndex)
                                // WRITE DOWN THE SCORE
                                
                                gamedata[0].scoreboard[0].penTarget = nil
                                // Let the Pen leave the scoreBoard
                                
                                for i in 0 ..< dicesArray.count {
                                    dicesArray[i].isHeld = false
                                    dicesArray[i].value = 0
                                }
                                rollCount = 3
                                // RESET THE ROLL BUTTON (NEW TURN)
                                
                                
                                if !gamedata[0].scoreboard[0].scoresArray.contains(nil) {
                                    goToEndView = true
                                } // AFTER 13 TURN, GAME END, GO TO THE END VIEW
                                
                            }
                            
                        }
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundStyle(Color.green)
                                .fontWeight(.bold)
                                .frame(height: 60)
                                .frame(maxWidth: .infinity)
                                .shadow(color: .black, radius: 0, x: 2, y: 2)
                            
                            Text("PLAY")
                                .bold()
                                .foregroundStyle(Color.white)
                                .shadow(color: .black, radius: 0, x: 2, y: 2)
                        }
                    }) // PLAY BUTTON
                }
            } // HSTACK
        } // NAVIGATIONSTACK
        .navigationDestination(isPresented: $goToEndView){
            
            EndView(finalScore: gamedata[0].scoreboard[0].returnTotalScore())
                .navigationBarBackButtonHidden()
            
        } // GO TO ENDVIEW
        
    }
    
    
}

#Preview {
    struct Preview: View {
        
        @State var rollCount = 3
        @State var dicesArray = Array(repeating: Dice(value: 3), count: 5)
        
        var body: some View {
            ButtonView(dicesArray: $dicesArray, rollCount: $rollCount)
                .modelContainer(for: GameData.self)
        }
    }
    return Preview()
}
