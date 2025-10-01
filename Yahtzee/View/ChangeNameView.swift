//
//  ChangeNameView.swift
//  Yahtzee
//
//  Created by 陳嘉國
//

import SwiftUI
import SwiftData

struct ChangeNameView: View {
    
    // MARK: - PROPERTIES
    
    @Bindable var playerData: PlayerData
    
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var router: Router
    
    @Binding var showingChangeNameView : Bool
    
    @State private var playerName: String = ""
    @State var startAnimation : Bool = false
    
    let firebasemodel = FirebaseModel()

    // MARK: - BODY
    
    var body: some View {
        
        ZStack {
            Color.gray.opacity(0.3)
                .onTapGesture {
                    showingChangeNameView.toggle()
                }
            // BACKGROUND TO AVOID USER TOUCH THING OTHER THAN WINDOW
            
            
            VStack(alignment: .center, spacing: 0) {
                
                Text("PlayerName")
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(Color.orange)
                
                HStack {
                    Spacer(minLength: 40)

                    TextField("\(playerData.name)", text: $playerName)
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .background{
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(Color.black.opacity(0.1))
                        }

                    Spacer(minLength: 40)

                } // HSTACK
                .padding(.top, 20)
                .padding(.vertical, 5)
                .background(Color.white)

                
                HStack {
                    Image(systemName: "exclamationmark.triangle")
                    Text("Please do not use your real name or other personal information.")
                }
                .multilineTextAlignment(.leading)
                .font(.headline)
                .fontWeight(.black)
                .foregroundColor(Color.red)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                
                
                HStack {
                    cancelButton
                    changeNameButton
                } // HSTACK
                .padding(.top, 10)
                .padding()
                .background(Color.white)
                .fixedSize(horizontal: false, vertical: true)
                
            } // VSTACK
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .padding(.horizontal, 40)
            .scaleEffect(startAnimation ? 1 : 0)
            .animation(.spring, value: startAnimation)
            .onAppear{
                startAnimation.toggle()
            }

        } //ZSTACK
        .ignoresSafeArea(.all)
        
    }
    
    // MARK: BUTTONS
    
    var cancelButton: some View {
        Button {
            self.showingChangeNameView.toggle()
        } label: {
            Text("Cancel")
                .font(.headline)
                .fontWeight(.black)
                .foregroundStyle(Color.gray)
                .padding()
                .lineLimit(1)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(color: Color.gray ,radius: 4, x: 0, y: 4)
        }
    }
    
    var changeNameButton: some View {
        Button {
            playerData.name = playerName
            if firebasemodel.isFirebaseConfigured() {
                firebasemodel.updatePlayerData(localUUID: nil, newName: playerName, newScore: nil)
            }
            self.showingChangeNameView.toggle()
        } label: {
            Text("OK")
                .font(.headline)
                .fontWeight(.black)
                .foregroundStyle(Color.white)
                .padding()
                .lineLimit(1)
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(color: Color.gray ,radius: 4, x: 0, y: 4)
        }
    }
    
}

#Preview {
    ChangeNamePreviewWrapper()
}

struct ChangeNamePreviewWrapper: View {
    @State private var showingChangeNameView = true
    @StateObject private var router = Router()
    @State private var playerData = PlayerData(name: "Player9527")

    var body: some View {
        ChangeNameView(
            playerData: playerData,
            showingChangeNameView: $showingChangeNameView
        )
    }
}
