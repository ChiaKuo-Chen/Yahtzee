//
//  FormRowStaticView.swift
//  Yahtzee
//
//  Displays a static row in the settings form with a small icon on the left,
//  a gray label in the center, and a black value on the right.
//  Commonly used for showing app metadata such as version, developer, or compatibility.
//
//  Created by 陳嘉國
//

import SwiftUI

struct FormRowStaticView: View {
    
    // MARK: - PROPERTIES
    
    // The name of the SF Symbol icon to display on the left.
    var icon: String
    
    // The label text displayed in gray (e.g., “Developer”).
    var firsrText: String
    
    // The corresponding value text displayed in black (e.g., “ChiaKuo-Chen”).
    var secondText: String
    
    // MARK: - BODY
    
    var body: some View {
        HStack(spacing: 12) {
            
            // Icon container
            ZStack {
                // Rounded background for the icon
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.gray)
                
                // SF Symbol icon
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.white)
            }
            .frame(width: 36, height: 36, alignment: .center)
            
            // Description label
            Text(firsrText)
                .foregroundStyle(.gray)
            
            Spacer()
            
            // Corresponding value or detail text
            Text(secondText)
                .foregroundStyle(.black)
        }
    }
}

#Preview("Preview") {
    FormRowStaticView(
        icon: "dice.fill",
        firsrText: "Application",
        secondText: "Yahtzee"
    )
    .padding()
}
