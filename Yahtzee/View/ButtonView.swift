//
//  ButtonView.swift
//  Yahtzee
//

import SwiftUI
import SwiftData

struct ButtonView: View {
    
    // MARK: - PROPERTIES
    @Query var gameSetting: [GameSettingsData]
    @EnvironmentObject var scoreboard : ScoreBoard
    
    @Binding var dicesArray: [Dice]
    @Binding var rollCount : Int

    @State private var goToEndView = false
    
    // MARK: - BODY
    
    var body: some View {
        
        NavigationStack {
            HStack {
                // ROLL BUTTON
                Button(action: {
                    
                    if rollCount > 0 && dicesArray.getDicesHeld().filter({$0 == true}).count < 5 {
                        
                        if gameSetting.first?.soundEffect == true {
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
                                   

                        for index in 0 ..< scoreboard.targetArray.count {
                            
                            if scoreboard.targetArray[index] == true {
                                                            
                                scoreboard.targetArray[index] = false
                                scoreboard.scoresArray[index] = scoreModel()
                                    .caculateScore( dicesArray.getDicesNumber(), indexModel().returnString(index) )
                                                                
                                // WRITE DWON THE SCORE

                                for i in 0 ..< dicesArray.count {
                                    dicesArray[i].isHeld = false
                                    dicesArray[i].value = 0
                                }

                                rollCount = 3
                                
                                // RESET THEROLL BUTTON
                            }
                            
                        }
                        
                        if !scoreboard.scoresArray.contains(nil) {
                            goToEndView = true
                        } // GAME END, GO TO THE END VIEW

                        

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
            
            EndView(finalScore: scoreboard.returnTotalScore())
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
                .environmentObject(ScoreBoard())
        }
    }
    return Preview()
}
