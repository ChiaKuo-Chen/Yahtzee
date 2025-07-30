//
//  ScoreView.swift
//  Yahtzee

import SwiftUI
import SwiftData

struct HeaderView: View {

    // MARK: - PROPERTIES
    @Bindable var gameData: GameData
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var router: Router
    
    var showingScore: Bool

    // MARK: - BODY

    var body: some View {
        HStack {
            
            Button(action: {
                router.path.removeAll()
            }, label: {
                Image(systemName: "house.circle")
                    .font(.system(size: 30))
                    .frame(alignment: .trailing)
            })
            
            Spacer()
            
            if showingScore {
                
                Text("SCORE : \(String(gameData.scoreboard[0].returnTotalScore()))")
                    .font(.system(size: 30))
                    .fontWeight(.heavy)
                    .padding(.vertical, 10)
                
                Spacer()
            }
            
            Image(systemName: gameData.soundEffect != false ? "speaker.wave.2.circle" : "speaker.slash.circle")
                .font(.system(size: 30))
                .onTapGesture {
                    gameData.soundEffect.toggle()
                    try? modelContext.save()
                }

                        
        } // HSTACK
        .padding(.horizontal, 10)
    }
}

#Preview("HeaderView Preview") {
    let container = try! ModelContainer(for: GameData.self, ScoreBoard.self, Dice.self)
    let previewGameData = generateInitialData()

    HeaderView(gameData: previewGameData, showingScore: true)
        .modelContainer(container)
        .environmentObject(Router())
        .foregroundStyle(Color.white)
        .background(Color.gray)
}
