//
//  DateModel.swift
//  Yahtzee
//
//  A utility class for formatting the current date into an ISO 8601 string format.
//  Used for timestamping scores or user actions consistently across the app.
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
