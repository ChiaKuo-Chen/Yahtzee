//
//  FetchView.swift
//  Yahtzee
//
//  Created by 陳嘉國 on 2025/9/13.
//

import SwiftUI


struct LeaderBoardView: View {
    
    // MARK: - PROPERTIES
    @EnvironmentObject var router: Router
    
    @State private var selectedOption = "你的名次"
    let options = ["你的名次", "TOP100"]
    @State var viewmodel = FetchViewModel()
    
    @State var playerName: String
    @State var playerID: String
    @State var playerScore: Int
    @State var playerTimeStamp: String
    @State var firebasePlayers: [Player] = []

    let firebasemodel = FirebaseModel()
    private var localPlayer: Player {
        Player(id: playerID,
               name: playerName,
               score: playerScore,
               timestamp: playerTimeStamp)
    }


    private let backgroundColor = Color(uiColor: UIColor(hex: "5E936C"))
    
    var leaderBoard: [Player] {
        let combined = viewmodel.users + [localPlayer] + firebasePlayers
        return combined.sorted { $0.score > $1.score }
    }
    
    var top100Leaderboard: [(rank: Int, player: Player)] {
        Array(leaderBoard.prefix(100).enumerated().map { (index, player) in
            (rank: index+1, player: player)
        })
    }
    
    var trimmedLeaderboard: [(rank: Int, player: Player)] {
        guard let localIndex = leaderBoard.firstIndex(where: { $0.id == localPlayer.id }) else {
            return leaderBoard.enumerated().map { (index, player) in (index + 1, player) }
        }
        
        let lowerBound = max(localIndex - 10, 0)
        let upperBound = min(localIndex + 10, leaderBoard.count - 1)
        let sliced = leaderBoard[lowerBound...upperBound]
        
        return Array(sliced.enumerated().map { (offset, player) in
            (rank: lowerBound + offset + 1, player: player)
        })
    }
    
    var leaderboardToShow: [(rank: Int, player: Player)] {
        let slice = selectedOption == "你的名次" ? trimmedLeaderboard : top100Leaderboard
        return Array(slice)
    }
        
    // MARK: - BODY
    var body: some View {
        
        
        VStack(alignment: .center) {
            
            HStack(spacing: 10) {
                Button(action: {
                    router.path.removeAll()
                }, label: {
                    Image(systemName: "house.circle")
                        .font(.system(size: 40))
                        .frame(alignment: .trailing)
                        .foregroundStyle(Color.white)
                })
                
                ForEach(options, id: \.self) { option in
                    Text(option)
                        .foregroundStyle(selectedOption == option ? Color.black : Color.white)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(selectedOption == option ? Color(uiColor: UIColor(hex: "E8FFD7")) : Color.gray)
                        .clipShape(RoundedRectangle(cornerRadius:20))
                        .onTapGesture {
                            selectedOption = option
                        }
                        .overlay{
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(selectedOption == option ? Color.white : Color.black, lineWidth: 1)
                        }
                        .padding(.horizontal, 5)
                }
            } // HSTACK
            .padding(.top, 8)
            
            HStack {
                Text("※最高得分存在相同者時，\n將會以時間上較先取得該分數的一方作為較高名次")
                    .fontWeight(.black)
                    .font(.footnote)
                    .foregroundStyle(Color.white)
                    .fontWeight(.black)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                
                Spacer()
            } // HSTACK
            
            ScrollViewReader { proxy in
                ScrollView {
                    switch viewmodel.status {
                    case .notStatred:
                        EmptyView()
                    case .fetching:
                        ProgressView()
                    case .successFetch:
                        
                        Color.clear
                            .frame(height: 1)
                            .id("top")
                        
                        if selectedOption == "你的名次" && playerScore == 0 {
                            VStack {
                                Spacer()
                                Text("你尚未進行過遊戲，因此沒有名次")
                                Spacer()
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal, 40)
                            .frame(height: 600)
                            .background(Color(uiColor: UIColor(hex: "E8FFD7")).opacity(0.6).clipShape(RoundedRectangle(cornerRadius: 20)))
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                            
                        } else {
                            
                            ForEach(leaderboardToShow, id: \.player.id) { item in
                                
                                let rank = item.rank
                                let player = item.player
                                
                                VStack {
                                    LeaderBoardBarView(index: rank, name: player.name, score: player.score)
                                        .id(player.id)
                                }
                                .overlay {
                                    if player.id == localPlayer.id {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.white, lineWidth: 4)
                                                .padding(.horizontal)
                                                .padding(-4)
                                            Text("你的名次")
                                                .padding(.horizontal, 4)
                                                .padding(.vertical, 2)
                                                .fontWeight(.bold)
                                                .foregroundStyle(Color.black)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .foregroundStyle(Color.white)
                                                )
                                                .offset(y: -25)
                                            // 因為 height 在 LeaderBoardBarView 是 50
                                        }
                                    }
                                }
                            }
                        }
                        
                    case .failed(let error):
                        Text(error.localizedDescription)
                    }
                } // SCROLLVIEW
                .scrollDisabled(selectedOption == "你的名次" && playerScore == 0 ? true : false)
                .scrollIndicators(.hidden)
                .onChange(of: selectedOption) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation {
                            if selectedOption == "你的名次" {
                                proxy.scrollTo(localPlayer.id, anchor: .center)
                            } else {
                                proxy.scrollTo("top")
                            }
                        }
                    }
                }
                .onAppear{
                    Task {
                        await viewmodel.getUserData()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            withAnimation {
                                proxy.scrollTo(localPlayer.id, anchor: .center)
                            }
                        }
                    } // Scroll To Player
                    firebasemodel.fetchLeaderboard { players in
                        firebasePlayers = players
                    }
                }
            }
        } // VSTACK
        .background(backgroundColor)
        
    }
}

#Preview {
    LeaderBoardView(playerName: "YOU", playerID: "00000000-0000-0000-0000-000000000000", playerScore: 290, playerTimeStamp: "2025-09-14T09:49:16.029418Z")
}
