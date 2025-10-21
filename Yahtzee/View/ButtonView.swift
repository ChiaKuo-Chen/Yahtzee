//
//  ButtonView.swift
//  Yahtzee
//
//  This view displays the main action buttons used in the Yahtzee game interface.
//  It contains:
//  - A ROLL button: lets the user roll dice (up to 3 times per turn).
//  - A PLAY button: allows the user to play/score after rolling (only shown if under 3 rolls).
//
//  Created by 陳嘉國
//

import SwiftUI
import SwiftData

struct ButtonView: View {
    
    // MARK: - PROPERTIES
    // The view model handles logic for rolling and playing actions.
    @State var viewModel: ButtonViewModel
    
    // MARK: - BODY
    
    var body: some View {
        
        
        HStack {
            // ROLL BUTTON
            Button(action: {
                viewModel.rollDice()
            }, // ACTION
                   label: {
                ZStack {
                    // Background: top lighter overlay for 3D feel
                    VStack(spacing: 0) {
                        Rectangle()
                            .foregroundStyle(Color.yellow)
                            .overlay(Color.white.opacity(0.5))

                        Rectangle()
                            .foregroundStyle(Color.yellow)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .frame(maxHeight: 60)
                    .frame(maxWidth: .infinity)
                    .shadow(color: .gray, radius: 0, x: 0, y: 2)

                    // Button Content: label and roll indicator dots
                    HStack {
                        Text("ROLL")
                            .bold()
                            .foregroundStyle(Color.black)
                        
                        // Dots indicate how many rolls have been used (up to 3)
                        ForEach(0 ... 2 , id: \.self) { index in
                            Circle()
                                .scaledToFit()
                                .frame(maxWidth: 25)
                                .foregroundStyle(viewModel.rollCount > index ? Color.green : Color.gray)
                        }
                    } // HSTACK
                    
                } // ZSTACK
            } // LABEL
            ) // ROLL BUTTON
            .buttonStyle(ShrinkButtonModifier())
            
            // MARK: - PLAY BUTTON
            // only shown if roll count < 3
            if viewModel.rollCount < 3 {
                Button(action: {
                    Task {
                        await viewModel.play()
                    }
                }, label: {
                    ZStack {
                        VStack(spacing: 0) {
                            Rectangle()
                                .foregroundStyle(Color.green)
                                .overlay(Color.white.opacity(0.5))

                            Rectangle()
                                .foregroundStyle(Color.green)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 40))
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color.black, lineWidth: 1)
                        )
                        .frame(maxHeight: 60)
                        .frame(maxWidth: .infinity)
                        .shadow(color: .gray, radius: 0, x: 0, y: 2)

                        Text("PLAY")
                            .bold()
                            .foregroundStyle(Color.white)
                            .shadow(color: .black, radius: 0, x: 2, y: 2)
                    }
                    
                }) // PLAY BUTTON
                .buttonStyle(ShrinkButtonModifier())
                
            }
        } // HSTACK
        
    }
    
    
}

#Preview("Preview") {
    
    // Create a mock data container for preview purposes
    let container = try! ModelContainer(for: GameData.self, ScoreBoard.self, Dice.self)
    let context = container.mainContext
    
    // Insert mock game data
    let previewGameData = generateInitialData()
    context.insert(previewGameData)
    try? context.save()
    
    // Create required dependencies for the view model
    let penObject = PenObject()
    let router = Router()
    let audioManager = AudioManager()
    
    // Initialize the ViewModel with the test context and dependencies
    let viewModel = ButtonViewModel(
        gameData: previewGameData,
        modelContext: context,
        penObject: penObject,
        router: router,
        audioManager: audioManager
    )
    
    // Return the actual view for live preview
    return ButtonView(viewModel: viewModel)
        .environmentObject(penObject)
        .environmentObject(router)
        .modelContainer(container)
}
