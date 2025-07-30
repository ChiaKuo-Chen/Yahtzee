//
//  Router.swift
//  Yahtzee
//
//  Created by 陳嘉國
//

import Foundation
import SwiftUI

class Router: ObservableObject {
    @Published var path : [Page] = []
}

enum Page: Hashable {
    case gameTable
    case end(finalScore: Int)
    case yahtzee
}

