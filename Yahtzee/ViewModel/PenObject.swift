//
//  PenObject.swift
//  Yahtzee
//
//  Manages the "pen" state used for selecting which score cell the player wants to write to.
//  The penTarget represents the currently selected cell index in the scoreboard.
//
//  Created by 陳嘉國
//

import Foundation

// ObservableObject representing the pen used by the player to select a score cell.
// `penTarget` stores the index of the currently targeted score cell, or nil if none.
class PenObject: ObservableObject {
    
    // The index of the scoreboard cell the pen is currently pointing to.
    // Nil means no cell is currently selected.
    @Published var penTarget: Int? = nil

    // Clears the pen target, indicating the pen is no longer ready to write.
    func leavePaper() {
        penTarget = nil
    }
    
    // Sets the pen target to the given scoreboard cell index,
    // indicating the pen is ready to write to that cell.
    // - Parameter target: The index of the scoreboard cell to write to.
    func takePaper(_ target: Int) {
        penTarget = target
    }
}
