//
//  GridRecordView.swift
//  Yahtzee
//
//  Created by 陳嘉國
//


import SwiftUI

struct Record: Identifiable {
    let id = UUID()
    let title: String
    let score: Int
}

struct GridRecordView: View {
    // 模擬 30 筆資料
    let records: [Record] = (1...30).map { i in
        Record(title: "Item \(i)", score: Int.random(in: 50...100))
    }

    // 三欄的網格配置
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(records) { record in
                    VStack(spacing: 8) {
                        Text(record.title)
                            .font(.headline)
                        Text("Score: \(record.score)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(12)
                }
            }
            .padding()
        }
    }
}

#Preview {
    GridRecordView()
}
