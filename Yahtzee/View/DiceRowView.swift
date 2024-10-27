//
//  RollView.swift
//  Yahtzee

import SwiftUI

struct DiceRowView: View {

    // MARK: - PROPERTIES
    @Binding var dicesArray : [Dice]

    // MARK: - BODY

    var body: some View {
        HStack {
            ForEach(0 ..< dicesArray.count, id: \.self) { index in
                Image("dice\(dicesArray[index].value)")
                    .resizable()
                    .scaledToFit()
                    .padding(.vertical, 5)
                    .padding(.horizontal, 5)
                    .onTapGesture {
                        if dicesArray[index].value != 0 {
                            dicesArray[index].isHeld.toggle()
                        }
                    }
                    .overlay(
                        Rectangle()
                            .stroke(dicesArray[index].isHeld ? Color.yellow : Color.gray, lineWidth: 2)
                    )
                    .rotationEffect( .degrees(dicesArray[index].isRoll) )
                    .animation(Animation.easeInOut(duration: 1), value: dicesArray[index].isRoll)

                
            }
        } // HSTACK
    }
}

#Preview {
    struct Preview: View {
        
        @State var array = Array(repeating: Dice(value: 3), count: 5)
        var body: some View {
            DiceRowView(dicesArray: $array)
        }
    }
    return Preview()
}
