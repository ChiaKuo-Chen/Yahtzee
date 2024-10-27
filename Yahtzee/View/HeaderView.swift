//
//  ScoreView.swift
//  Yahtzee

import SwiftUI
import SwiftData

struct HeaderView: View {

    // MARK: - PROPERTIES
    @Query var gameSetting: [GameSettingsData]
    @EnvironmentObject var scoreboard : ScoreBoard
    
    // MARK: - BODY

    var body: some View {
        HStack {
            
            NavigationLink(destination: {
                CoverView()
                    .environmentObject(ScoreBoard())
                    .modelContainer(for: GameSettingsData.self)
                    .navigationBarBackButtonHidden()
            },
                           label: {
                Image(systemName: "house.circle")
                    .font(.system(size: 30))
                    .foregroundStyle(Color.white)
                    .frame(alignment: .trailing)
            })
            
            Spacer()

            Text("SCORE : \(scoreboard.returnTotalScore())")
                .font(.system(size: 30))
                .fontWeight(.heavy)
                .foregroundStyle(Color.white)
                .padding(.vertical, 10)
            
            Spacer()
            
            Image(systemName: gameSetting.first?.soundEffect != false ? "speaker.wave.2.circle" : "speaker.slash.circle")
                .font(.system(size: 30))
                .foregroundStyle(Color.white)
                .onTapGesture {
                    gameSetting.first?.soundEffect.toggle()
                }

                        
        } // HSTACK
        .padding(.horizontal, 10)
    }
}

#Preview {
    struct Preview: View {
        
        var body: some View {
            HeaderView()
                .environmentObject(ScoreBoard())
        }
    }
    return  Preview()
}
