//
//  SettingsView.swift
//  Yahtzee
//
//  Created by 陳嘉國
//
//  Displays the Settings screen, including sound toggle, external links,
//  and app information. Supports SwiftData persistence.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    
    // MARK: - PROPERTIES
    
    // Bound `GameData` model to sync user settings in real-time.
    @Bindable var gameData: GameData
    // Access to the SwiftData model context for saving updates.
    @Environment(\.modelContext) private var modelContext
    // Used to dismiss the current view (sheet or navigation).
    @Environment(\.dismiss) var dismiss
    
    // MARK: - BODY
    var body: some View {
        VStack {
            // MARK: - FORM
            Form {
                
                // MARK: - SECTION 1: Game Settings
                Section {
                    // Toggle for enabling or disabling sound effects.
                    Toggle(isOn: $gameData.soundEffect) {
                        HStack {
                            // Icon inside a rounded rectangle border
                            ZStack {
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .strokeBorder(Color.primary, lineWidth: 2)
                                
                                Image(systemName: "speaker.wave.2.fill")
                                    .font(.system(size: 28, weight: .medium))
                                    .foregroundStyle(Color.primary)
                            }
                            .frame(width: 44, height: 44)
                            
                            // Toggle label text
                            Text("Sound Effects".uppercased())
                                .fontWeight(.bold)
                                .foregroundStyle(Color.primary)
                        }
                    }
                    // Tint color of the toggle switch
                    .tint(.green)
                    // Automatically saves the state change to SwiftData
                    .onChange(of: gameData.soundEffect) {
                        try? modelContext.save()
                    }
                } header: {
                    Text("Game Settings")
                }

                // MARK: - SECTION 2: External Links
                Section {
                    // Link to the Wikipedia article about Yahtzee.
                    FormRowLinkView(
                        iconSystemName: "globe",
                        color: .blue,
                        text: "Wiki",
                        link: "https://zh.wikipedia.org/zh-tw/%E5%BF%AB%E8%89%87%E9%AA%B0%E5%AD%90"
                    )

                    // Link to the developer’s GitHub page.
                    FormRowLinkView(
                        imageName: "githubLogo",
                        color: .black,
                        text: "GitHub",
                        link: "https://github.com/ChiaKuo-Chen"
                    )
                } header: {
                    Text("Know More About Yahtzee")
                }
                .padding(.vertical, 3)
                
                // MARK: - SECTION 3: App Information
                Section {
                    // Static info rows for app metadata.
                    FormRowStaticView(icon: "dice.fill", firsrText: "Application", secondText: "Yahtzee")
                    FormRowStaticView(icon: "checkmark", firsrText: "Compatibility", secondText: "iPhone, iPad")
                    FormRowStaticView(icon: "keyboard", firsrText: "Developer", secondText: "ChiaKuo-Chen")
                    FormRowStaticView(icon: "paintbrush", firsrText: "Designer", secondText: "ChiaKuo-Chen")
                    FormRowStaticView(icon: "document", firsrText: "Version", secondText: "3.14159")
                } header: {
                    Text("About the Application")
                }
                .padding(.vertical, 3)
            } //: FORM
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            
            // MARK: - FOOTER
            Text("Copyright © All rights reserved.\nChiaKuo-Chen")
                .multilineTextAlignment(.center)
                .font(.footnote)
                .padding(.top, 6)
                .padding(.bottom, 8)
                .foregroundStyle(Color.secondary)
            
        } //: VSTACK
        .toolbar {
            // Close button in the top-right corner.
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
            }
        }
        // Navigation settings
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview("SettingsView Preview") {
    // MARK: - SWIFTDATA PREVIEW SETUP
    // Create an in-memory SwiftData container for preview testing.
    let container = try! ModelContainer(
        for: GameData.self,
        Dice.self,
        ScoreBoard.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    let context = container.mainContext
    
    // Generate sample GameData for preview.
    let previewGameData = generateInitialData()
    context.insert(previewGameData)
    try? context.save()
    
    // Display the SettingsView inside a NavigationStack.
    return NavigationStack {
        SettingsView(gameData: previewGameData)
            .modelContainer(container)
    }
}
