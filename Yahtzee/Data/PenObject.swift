//
//  PenObject.swift
//  Yahtzee
//

import Foundation


class PenObject: ObservableObject {
    
    @Published var penTarget : Int? = nil

    func leavePaper() {
        penTarget = nil
    }
    
    func takePaper(_ target: Int) {
        penTarget = target
    }

}
