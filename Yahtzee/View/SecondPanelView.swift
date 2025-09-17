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

    // MARK: - BODY
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(panelColor)
            .scaledToFit()
            .shadow(radius: 0, y: scoreAlreadyWritten ? 0 : 6)
            .overlay {
                if scoreAlreadyWritten {
                    Text("\(writtenScore!)")
                        .font(writtenScore! <= 99 ? .title : .subheadline)
                        .fontWeight(.black)
                        .foregroundStyle(.black)
                } else {
                    Text("\(potentialScore)")
                        .font(potentialScore <= 99 ? .title : .subheadline)
                        .fontWeight(.black)
                        .foregroundStyle(categoryIndex == penTarget ? .black : .gray)
                }
            }
            .offset(y: scoreAlreadyWritten ? 0 : -6)
            .onTapGesture {
                if scoreAlreadyWritten {
                    penObject.leavePaper()
                } else {
                    penObject.takePaper(categoryIndex)
                }
                //print(penObject.penTarget ?? "Not found")
            }
    }

    // MARK: - TO SIMPLY CODE
    var diceArray: [Dice] { gameData.diceArray }
    var scoreboard: ScoreBoard { gameData.scoreboard[0] }
    var potentialScore: Int { scoreModel.caculateScore(diceArray, category: category) }
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
}

#Preview {
    let container = try! ModelContainer(for: GameData.self, Dice.self, ScoreBoard.self)
    let previewGameData = generateInitialData()
    let penObject = PenObject()

    // 範例選一個 category
    return SecondPanelView(gameData: previewGameData, category: "threes")
        .environmentObject(penObject)
        .modelContainer(container)
}
