//
//  ScoreView.swift
//  Yahtzee

import SwiftUI
import SwiftData

struct ContentHeaderView: View {

    // MARK: - PROPERTIES
    @Query var gamedata: [GameData]
    @Environment(\.modelContext) private var modelContext
    
    // MARK: - BODY

    var body: some View {
        HStack {
            
            NavigationLink(destination: {
                CoverView()
                    .modelContainer(for: GameData.self)
                    .navigationBarBackButtonHidden()
            },
                           label: {
                Image(systemName: "house.circle")
                    .font(.system(size: 30))
                    .foregroundStyle(Color.white)
                    .frame(alignment: .trailing)
            })
            
            Spacer()

            Text("SCORE : \(String(gamedata[0].scoreboard[0].returnTotalScore()))")
                .font(.system(size: 30))
                .fontWeight(.heavy)
                .foregroundStyle(Color.white)
                .padding(.vertical, 10)
            
            Spacer()
            
            Image(systemName: gamedata.first?.soundEffect != false ? "speaker.wave.2.circle" : "speaker.slash.circle")
                .font(.system(size: 30))
                .foregroundStyle(Color.white)
                .onTapGesture {
                    gamedata.first?.soundEffect.toggle()
                    try? modelContext.save()
                }

                        
        } // HSTACK
        .padding(.horizontal, 10)
    }
}

#Preview {
    struct Preview: View {
        
        var body: some View {
            ContentHeaderView()
                .modelContainer(for: GameData.self)
                .background(Color.gray)
        }
    }
    return  Preview()
}
