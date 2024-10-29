////
////  TestView.swift
////  Yahtzee
////
//
//import SwiftUI
//import SwiftData
//
//struct TestView: View {
//    // MARK: - PROPERTIES
//    @Query var gamedata: [GameData]
//    @Environment(\.modelContext) private var modelContext
//
//    // MARK: - BODY
//
//    var body: some View {
//        
//        VStack {
//            Text("DELETE ALL SWIFT DATA")
//                .font(.system(size: 45))
//                .foregroundStyle(Color.white)
//                .frame(alignment: .trailing)
//                .padding()
//                .onTapGesture {
//                    print("DELETE ALL SWIFT DATA")
//                    modelContext.delete(gamedata[0])
//                    modelContext.insert(generateInitialData())
//                }
//                .background(Color.blue)
//
//            Text("DELETE SCOREBOARD DATA")
//                .font(.system(size: 45))
//                .foregroundStyle(Color.white)
//                .frame(alignment: .trailing)
//                .padding()
//                .onTapGesture {
//                    print("DELETE SCOREBOARD DATA")
//                    gamedata[0].scoreboard[0].NewScoreboard()
//                }
//                .background(Color.blue)
//
//            Text("DELETE DICE DATA")
//                .font(.system(size: 45))
//                .foregroundStyle(Color.white)
//                .frame(alignment: .trailing)
//                .padding()
//                .onTapGesture {
//                    print("DELETE DICE DATA")
//                    gamedata[0].NewDiceArray()
//                }
//                .background(Color.blue)
//
//        }
//        // BUTTON FOR DELETE SWIFT DATA
//        // ONLY USE FOR TEST
//
//    }
//}
//
//#Preview {
//    TestView()
//        .modelContainer(for: GameData.self)
//}
