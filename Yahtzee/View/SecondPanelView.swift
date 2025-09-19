//
//  SecondPanelView.swift
//  Yahtzee
//

import SwiftUI
import SwiftData
struct SecondPanelView: View {
    
    // MARK: - PROPERTIES
    @EnvironmentObject var penObject: PenObject
    @Bindable var gameData: GameData

    let category: String
    let categoryModel = CategoryModel()
    let scoreModel = ScoreModel()
    
    private let unselectPanelColor = "#d8ffb2"
    private let lightingColor = [Color.white.opacity(1), Color.clear,
                                 Color.clear, Color.clear]
    
    var diceArray: [Dice] { gameData.diceArray }
    var scoreboard: ScoreBoard { gameData.scoreboard[0] }
    // This Onw Would Tell the Score
    var potentialScore: Int { scoreModel.caculateScore(diceArray, category: category, scoreBoard: scoreboard) }
    var categoryIndex: Int { categoryModel.returnIndex(category) }
    var scoreAlreadyWritten: Bool { writtenScore != nil }
    var writtenScore: Int? { scoreboard.scoresArray[categoryIndex] }
    var penTarget: Int? { penObject.penTarget }
    
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
        .padding()
        .background(Color.blue)
}
