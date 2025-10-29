//
//  FormRowLinkView.swift
//  Yahtzee
//
//  Created by 陳嘉國
//
//  Displays a settings-style row with an icon, label, and link button.
//  Supports both SF Symbols and custom asset images.
//

import SwiftUI

struct FormRowLinkView: View {
    
    // MARK: - PROPERTIES
    // The name of the SF Symbol icon to display (optional).
    var iconSystemName: String? = nil
    // The name of a custom image from the app's asset catalog (optional).
    var imageName: String? = nil
    // The background color for the icon container.
    var color: Color
    // The text label displayed next to the icon.
    var text: String
    // The external link to open when the button is tapped.
    var link: String

    // MARK: - BODY
    
    var body: some View {
        HStack {
            ZStack {
                // Icon background container
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .foregroundStyle(color)
                
                // Display a custom image if provided
                if let imageName = imageName {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .padding(5)
                        .foregroundStyle(.white)
                }
                // Otherwise, display an SF Symbol
                else if let iconSystemName = iconSystemName {
                    Image(systemName: iconSystemName)
                        .imageScale(.large)
                        .foregroundStyle(.white)
                }
            }
            .frame(width: 36, height: 36)
            
            // Row label text
            Text(text)
                .foregroundStyle(.gray)
            
            Spacer()
            
            // Link button that opens an external URL
            Button(action: {
                if let url = URL(string: link) {
                    UIApplication.shared.open(url)
                }
            }, label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
            })
            .tint(Color(.systemGray2))
        }
    }
}

// MARK: - PREVIEWS

#Preview("System Icon") {
    FormRowLinkView(
        iconSystemName: "globe",
        color: .pink,
        text: "Website",
        link: "https://zh.wikipedia.org/zh-tw/%E5%BF%AB%E8%89%87%E9%AA%B0%E5%AD%90"
    )
    .padding()
}

#Preview("Asset Image") {
    FormRowLinkView(
        imageName: "githubLogo",
        color: .black,
        text: "GitHub",
        link: "https://github.com/ChiaKuo-Chen"
    )
    .padding()
}
