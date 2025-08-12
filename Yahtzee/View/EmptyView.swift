//
//  EmptyView.swift
//  Yahtzee
//
//  Created by 陳嘉國 on 2025/8/11.
//

import SwiftUI
import Vortex

struct EmptyView: View {
    var body: some View {
        
        ZStack {
            VortexView(.fireworks) {
                Circle()
                    .fill(Color.green)
                    .blendMode(.plusLighter)
                    .frame(width: 132)
                    .tag("circle")
            }
            
            VortexView(.fireworks) {
                Circle()
                    .fill(Color.white)
                    .blendMode(.plusLighter)
                    .frame(width: 32)
                    .tag("circle")
            }

        }
        .background(Color.black)

    }
}

#Preview {
    EmptyView()
}
