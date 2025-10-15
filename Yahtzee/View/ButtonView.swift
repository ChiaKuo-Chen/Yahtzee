//
//  ButtonView.swift
//  Yahtzee
//

import SwiftUI
import SwiftData

struct ButtonView: View {
    
    // MARK: - PROPERTIES
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

                    HStack {
                        Text("ROLL")
                            .bold()
                            .foregroundStyle(Color.black)
                        
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
            
            // PLAY BUTTON
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
    
    let container = try! ModelContainer(for: GameData.self, ScoreBoard.self, Dice.self)
    let context = container.mainContext
    
    let previewGameData = generateInitialData()
    context.insert(previewGameData)
    try? context.save()
    
    let penObject = PenObject()
    let router = Router()
    let audioManager = AudioManager()
    
    let viewModel = ButtonViewModel(
        gameData: previewGameData,
        modelContext: context,
        penObject: penObject,
        router: router,
        audioManager: audioManager
    )
    
    return ButtonView(viewModel: viewModel)
        .environmentObject(penObject)
        .environmentObject(router)
        .modelContainer(container)
}
