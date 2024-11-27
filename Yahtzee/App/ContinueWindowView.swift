//
//  ContinueButtonView.swift
//  Yahtzee
//

import SwiftUI
import SwiftData

struct ContinueWindowView: View {
    
    // MARK: - PROPERTIES
    @Query var gamedata: [GameData]
    @Environment(\.modelContext) private var modelContext
    
    @Binding var showingContinueView : Bool
    @Binding var goToContentView : Bool
    @State var startAnimation : Bool = false
    
    // MARK: - BODY
    
    var body: some View {
                    
            ZStack {
                Color.gray.opacity(0.6)
                // BACKGROUND TO AVOID USER TOUCH THING OTHER THAN WINDOW
                
                VStack(spacing: 0) {
                    
                        
                    Text("CONTINUE?")
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 5)
                        .padding()
                        .background(Color.orange)
                        .overlay{
                        
                            HStack {
                                Spacer()
                                
                                
                                Button(action: {
                                    self.showingContinueView.toggle()
                                }, label: {
                                    Rectangle()
                                        .aspectRatio(1.0, contentMode: .fit)
                                        .foregroundStyle(Color.red)
                                        .font(.largeTitle)
                                        .border(Color.white, width: 2)
                                        .padding()
                                        .overlay{
                                            Text("X")
                                                .font(.title3)
                                                .fontWeight(.black)
                                                .foregroundStyle(Color.white)
                                        }

                                }) // BUTTON TO DISMISS THE WINDOW
                            } // HSTACK

                        }

                        


                    Text(
"""
Would you like to conitinue your previous game or start a new one?
""")
                    .multilineTextAlignment(.center)
                    .font(.title3)
                    .fontWeight(.black)
                    .foregroundColor(Color.brown)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)

                    HStack {
                        newGameButton
                        continueGameButton
                    } // HSTACK
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
    
    var newGameButton: some View {
        Button {
            gamedata[0].prepareToNewPlay()
            try? modelContext.save()
            
            goToContentView.toggle()

        } label: {
            Text("NEW GAME")
                .font(.headline)
                .fontWeight(.black)
                .foregroundStyle(Color.white)
                .padding()
                .lineLimit(1)
                .frame(maxWidth: .infinity)
                .background(Color.orange)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(color: Color.gray ,radius: 0, x: 2, y: 2)
        }
    }

    var continueGameButton: some View {
        Button {
            goToContentView.toggle()
        } label: {
            Text("CONTINUE")
                .font(.headline)
                .fontWeight(.black)
                .foregroundStyle(Color.white)
                .padding()
                .lineLimit(1)
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(color: Color.gray ,radius: 0, x: 2, y: 2)
        }
    }

}

#Preview {
    struct Preview: View {
        
        @State private var showingContinueView: Bool = true
        @State var goToContentView : Bool = false

        var body: some View {
            ContinueWindowView(showingContinueView: $showingContinueView, goToContentView: $goToContentView)
                .modelContainer(for: GameData.self)
        }
    }
    return Preview()
}
