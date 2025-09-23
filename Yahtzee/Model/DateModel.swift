//
//  DateModel.swift
//  Yahtzee
//
//  Created by 陳嘉國
//

import Foundation

class DateModel {
 
    func getCurrentDateString() -> String {
        let date = Date()
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter.string(from: date)
    }
    
}
