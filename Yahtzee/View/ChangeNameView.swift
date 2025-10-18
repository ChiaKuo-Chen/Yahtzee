//
//  ChangeNameView.swift
//  Yahtzee
//
//  Created by 陳嘉國
//

import SwiftUI
import CoreData

struct ChangeNameView: View {
    
    // MARK: - PROPERTIES
    @Environment(\.managedObjectContext) private var viewContext     // CoreData
    @ObservedObject var corePlayer: CorePlayer // CoreData
    
    @EnvironmentObject var router: Router
    @Binding var showingChangeNameView : Bool // Show This Entire Window, or not (dismiss).
    
    @State private var textName: String = ""
    @State var startAnimation : Bool = false
    
    let firebasemodel = FirebaseModel()  // For FireStore On Google(FireBase)

    // MARK: - BODY
    
    var body: some View {
        
        ZStack {
            // BACKGROUND TO AVOID USER TOUCH THING OTHER THAN WINDOW
            Color.gray.opacity(0.3)
                .onTapGesture {
                    showingChangeNameView.toggle()
                }
            
            
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

                    // Player Name in gray RoundedRectangle.
                    TextField(corePlayer.name ?? "PlayerName", text: $textName)
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

                // Warning Word.
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
            if textName != "" {
                corePlayer.name = textName
                try? viewContext.save()
                if firebasemodel.isFirebaseConfigured() {
                    firebasemodel.updatePlayerData(localUUID: nil, newName: corePlayer.name, newScore: nil)
                }
                self.showingChangeNameView.toggle()
            }
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


struct ChangeNameView_Previews: PreviewProvider {
    
    static var previewContext: NSManagedObjectContext = {
        let container = NSPersistentContainer(name: "Yahtzee")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load in-memory store: \(error)")
            }
        }
        
        return container.viewContext
    }()
    
    static var mockPlayer: CorePlayer = {
        let player = CorePlayer(context: previewContext)
        player.name = "PreviewPlayer"
        return player
    }()
    
    @State static var isShowing = true
    
    static var previews: some View {
        ChangeNameView(corePlayer: mockPlayer, showingChangeNameView: .constant(true))
            .environment(\.managedObjectContext, previewContext)
            .environmentObject(Router())
    }
}
