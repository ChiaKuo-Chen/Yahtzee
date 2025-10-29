//
//  FormRowStaticView.swift
//  Yahtzee
//
//  Created by 陳嘉國
//

import SwiftUI

struct FormRowStaticView: View {
    // MARK - PROPERTIES
    
    var icon: String
    var firsrText: String
    var secondText: String
    
    // MARK - BODY
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous).fill(Color.gray)
                Image(systemName: icon)
                    .foregroundStyle(Color.white)
            }
            .frame(width: 36, height: 36, alignment: .center)
            Text(firsrText).foregroundStyle(Color.gray)
            Spacer()
            Text(secondText).foregroundStyle(Color.black)
        }
    }
}

#Preview {
    FormRowStaticView(icon: "gear", firsrText: "Application", secondText: "Todo")
        .padding()
}
