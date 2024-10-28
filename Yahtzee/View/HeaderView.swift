//
//  ScoreView.swift
//  Yahtzee

import SwiftUI
import SwiftData

struct HeaderView: View {

    // MARK: - PROPERTIES
    @Query var gamedata: [GameData]
    
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

            Text("SCORE : \(gamedata[0].returnTotalScore())")
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
                }

                        
        } // HSTACK
        .padding(.horizontal, 10)
    }
}

#Preview {
    struct Preview: View {
        
        var body: some View {
            HeaderView()
                .modelContainer(for: GameData.self)
                .background(Color.gray)
        }
    }
    return  Preview()
}
