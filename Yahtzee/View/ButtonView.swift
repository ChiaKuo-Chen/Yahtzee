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
    
    private let categorymodel = CategoryModel()
    private let scoremodel = ScoreModel()
    
    // MARK: - BODY
    
    var body: some View {
        
        
        HStack {
            // ROLL BUTTON
            Button(action: {
                
                if rollcount > 0 && dicearray.getDicesHeld().filter({$0 == true}).count < 5 {
                    
                    if gamedata.first?.soundEffect == true {
                        playSound(sound: "diceRoll", type: "mp3")
                    }
                    
                    for item in 0 ..< 5 {
                        dicearray[item].roll()
                    }
                    gamedata[0].scoreboard[0].rollCount -= 1
                    
                    try? modelContext.save()
                    
                    for i in 1 ... 6 {
                        if ( dicearray.getDicesNumber().filter({$0 == i}).count == 5 ) {
                            goToYahtzeeView.toggle()
                        }
                    }
                    // SPECIAL ANIMATION FOR YAHTZEE
                    
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
                        
                        ForEach(0 ... 2 , id: \.self) { index in
                            Circle()
                                .scaledToFit()
                                .frame(maxWidth: 25)
                                .foregroundStyle(rollcount > index ? Color.green : Color.gray)
                            
                        }
                        
                    } // HSTACK
                } // ZSTACK
            } // LABEL
            ) // ROLL BUTTON
            
            // PLAY BUTTON
            if rollcount < 3 {
                Button(action: {
                    
                    if let penIndex = scoreboard.penTarget {
                        
                        scoreboard.updateScoreBoard(
                            newScore: scoremodel.caculateScore (dicearray, category: categorymodel.returnCategory(penIndex))
                            ,penIndex: penIndex)
                        // Write Score Down
                        
                        scoreboard.penTarget = nil
                        // Let the Pen leave the scoreBoard
                        
                        for i in 0 ..< 5 {
                            dicearray[i].isHeld = false
                            dicearray[i].value = 0
                        }
                        scoreboard.rollCount = 3
                        // RESET THE ROLL BUTTON (NEW TURN)
                        
                        try? modelContext.save()
                        
                        if !(scoreboard.scoresArray.contains(nil)) {
                            goToEndView.toggle()
                        }
                        // AFTER 13 TURN, GAME END, GO TO THE END VIEW
                        
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
        
        // MARK: - TO SIMPLY THE CODE
        var scoreboard : ScoreBoard { gamedata[0].scoreboard[0] }
        var rollcount : Int { scoreboard.rollCount }
        var dicearray : [Dice] { gamedata[0].diceArray }
        
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
