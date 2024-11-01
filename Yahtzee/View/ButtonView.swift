//
//  ButtonView.swift
//  Yahtzee
//

import SwiftUI
import SwiftData

struct ButtonView: View {
    
    // MARK: - PROPERTIES
    @Query var gamedata: [GameData]
    @Environment(\.modelContext) private var modelContext    
    
    @Binding var goToYahtzeeView : Bool
    @Binding var goToEndView : Bool

    private let scoremodel = ScoreModel()
    
    // MARK: - BODY
    
    var body: some View {
        
        let scoreBoard = gamedata[0].scoreboard[0]
        
            HStack {
                // ROLL BUTTON
                Button(action: {
                    
                    if scoreBoard.rollCount > 0 && gamedata[0].diceArray.getDicesHeld().filter({$0 == true}).count < 5 {
                        
                        if gamedata.first?.soundEffect == true {
                            playSound(sound: "diceRoll", type: "mp3")
                        }
                        
                        for item in 0 ..< 5 {
                            gamedata[0].diceArray[item].roll()
                        }
                        scoreBoard.rollCount -= 1
                        
                        try? modelContext.save()

                        for i in 1 ... 6 {
                            if ( gamedata[0].diceArray.getDicesNumber().filter({$0 == i}).count == 5 ) {
                                goToYahtzeeView.toggle()
                            }
                        }
                        // SPECIAL ANIMATE FOR YAHTZEE

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
                                .foregroundStyle(scoreBoard.rollCount > 0 ? Color.green : Color.gray)
                            Circle()
                                .scaledToFit()
                                .frame(maxWidth: 25)
                                .foregroundStyle(scoreBoard.rollCount > 1 ? Color.green : Color.gray)
                            Circle()
                                .scaledToFit()
                                .frame(maxWidth: 25)
                                .foregroundStyle(scoreBoard.rollCount > 2 ? Color.green : Color.gray)
                            
                        } // HSTACK
                    } // ZSTACK
                } // LABEL
                ) // ROLL BUTTON
                
                // PLAY BUTTON
                if scoreBoard.rollCount < 3 {
                    Button(action: {
                        
                        if scoreBoard.penTarget != nil {
                                                        
                            if let penIndex = scoreBoard.penTarget {
                                
                                scoreBoard.updateScoreBoard(
                                    newScore: scoremodel.caculateScore(
                                        gamedata[0].diceArray,index: penIndex)
                                    ,penIndex: penIndex)
                                // WRITE DOWN THE SCORE
                                
                                scoreBoard.penTarget = nil
                                // Let the Pen leave the scoreBoard
                                
                                for i in 0 ..< 5 {
                                    gamedata[0].diceArray[i].isHeld = false
                                    gamedata[0].diceArray[i].value = 0
                                }
                                scoreBoard.rollCount = 3
                                // RESET THE ROLL BUTTON (NEW TURN)
                                
                                try? modelContext.save()

                                if !(scoreBoard.scoresArray.contains(nil)) {
                                    goToEndView.toggle()
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
            
        
    }
    
    
}

#Preview {
    struct Preview: View {
       
        @State private var goToYahtzeeView = false
        @State private var goToEndView = false

        var body: some View {
            ButtonView(goToYahtzeeView: $goToYahtzeeView, goToEndView: $goToEndView)
                .modelContainer(for: GameData.self)
        }
    }
    return Preview()
}
