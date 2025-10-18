//
//  PenObject.swift
//  Yahtzee
//

import Foundation

// Before the Pen write down the Score, it need to exist.
class PenObject: ObservableObject {
    
    // Whcih cell is Pen (Player) will write on?
    @Published var penTarget : Int? = nil

    // The pen is not ready yet.
    func leavePaper() {
        penTarget = nil
    }
    
    // The pen is ready to decide which cell to writ down score.
    func takePaper(_ target: Int) {
        penTarget = target
    }

}
