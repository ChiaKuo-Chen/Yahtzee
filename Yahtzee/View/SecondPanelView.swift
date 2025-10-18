//
//  SecondPanelView.swift
//  Yahtzee
//

import SwiftUI
import SwiftData
struct SecondPanelView: View {
    
    // MARK: - PROPERTIES
    
    // Pen, for wirte down the Score on the Spefic Cell On ScoreBoad(Paper)
    @EnvironmentObject var penObject: PenObject
    @Bindable var gameData: GameData // SwiftData
    
    // In yahtzee. the Score calculate from Rule, This Tell us what is rule now.
    let category: String
    // It sort the all possible rule.
    let categoryModel = CategoryModel()
    // With this rules, it could calculate the >>> Score <<<.
    let scoreModel = ScoreModel()
    
    private let unselectPanelColor = "#d8ffb2"
    private let lightingColor = [Color.white.opacity(1), Color.clear,
                                 Color.clear, Color.clear]
    
    // Dice Result
    var diceArray: [Dice] { gameData.diceArray }
    // ScoreBaord, the paper which record the score.
    var scoreboard: ScoreBoard { gameData.scoreboard[0] }
    // This Onw Would Tell the Score
    var potentialScore: Int { scoreModel.calculateScore(diceArray, category: category, scoreBoard: scoreboard) }
    // Rule Index
    var categoryIndex: Int { categoryModel.returnIndex(category) }
    // If the score already written, in can not be change or overwrite it.
    var scoreAlreadyWritten: Bool { writtenScore != nil }
    // If the score already written, show that score.
    var writtenScore: Int? { scoreboard.scoresArray[categoryIndex] }
    
    // Pen, for wirte down the Score on the Spefic Cell On ScoreBoad(Paper)
    var penTarget: Int? { penObject.penTarget }
    
    // The PanelCell is seleceted, it's color is green,
    // other cell should be light green
    // or white, if it already write down the score.
    var panelColor: Color {
        if scoreAlreadyWritten {
            return Color.white
        } else if categoryIndex == penTarget {
            return Color.green
        } else {
            return Color(UIColor(hex: unselectPanelColor))
        }
    }
    
    // MARK: - BODY
    var body: some View {
        
        RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(panelColor)
            .scaledToFit()
            .shadow(color: Color.black,
                    radius: 0,
                    x: scoreAlreadyWritten ? 0 : 2,
                    y: scoreAlreadyWritten ? 0 : 3)
            .shadow(color: Color.black,
                    radius: 0,
                    x: scoreAlreadyWritten ? 0 : -2,
                    y: scoreAlreadyWritten ? 0 : 3)
            .overlay {
                if scoreAlreadyWritten {
                    Text("\(writtenScore!)")
                        .font(writtenScore! <= 99 ? .title : .title2)
                        .fontWeight(.black)
                        .foregroundStyle(.black)
                } else {
                    Text("\(potentialScore)")
                        .font(potentialScore <= 99 ? .title : .title2)
                        .fontWeight(.black)
                        .foregroundStyle(categoryIndex == penTarget ? .black : .gray)
                }
            }
            .overlay{
                // Lighting, visual effects Only.
                if panelColor == Color(UIColor(hex: unselectPanelColor)) {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(
                            LinearGradient(
                                colors: lightingColor,
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                }
            }
            .offset(y: scoreAlreadyWritten ? 0 : -6)
            .onTapGesture {
                if scoreAlreadyWritten {
                    penObject.leavePaper()
                } else {
                    penObject.takePaper(categoryIndex)
                }
            }
        
        
    }
    
}

#Preview {
    let container = try! ModelContainer(for: GameData.self, Dice.self, ScoreBoard.self)
    let previewGameData = generateInitialData()
    let penObject = PenObject()
    
    // 範例選一個 category
    return SecondPanelView(gameData: previewGameData, category: "threes")
        .environmentObject(penObject)
        .modelContainer(container)
        .padding(.vertical, 100)
        .padding()
        .background(Color.blue)
}
