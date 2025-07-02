//
//  CoverHeaderView.swift
//  Yahtzee
//

import SwiftUI
import SwiftData

struct EndHeaderView: View {
    
    // MARK: - PROPERTIES
    @Query var gamedata: [GameData]
    @Environment(\.modelContext) private var modelContext

    // MARK: - BODY

    var body: some View {
        HStack {
            NavigationLink(destination: {
                ContentView()
                    .modelContainer(for: GameData.self)
                    .navigationBarBackButtonHidden()
            },
                           label: {
                Image(systemName: "house.circle")
                    .font(.system(size: 45))
                    .foregroundStyle(Color.black)
                    .frame(alignment: .trailing)
            })
            
            Spacer()
            
            Image(systemName: gamedata.first?.soundEffect != false ? "speaker.wave.2.circle" : "speaker.slash.circle")
                    .font(.system(size: 45))
                    .foregroundStyle(Color.black)
                    .frame(alignment: .trailing)
                    .onTapGesture {
                        gamedata.first?.soundEffect.toggle()
                        try? modelContext.save()
                    }
                    .frame(alignment: .topTrailing)
        }
        .padding(.horizontal)
    }
}

#Preview {
    EndHeaderView()
        .modelContainer(for: GameData.self)
        .background(Color.gray)
}
