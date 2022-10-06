//
//  Status.swift
//  ProjectManager
//
//  Created by minsson on 2022/09/15.
//

import SwiftUI

enum Status {
    case todo
    case doing
    case done
    
    var description: String {
        switch self {
        case .todo:
            return "TODO"
        case .doing:
            return "DOING"
        case .done:
            return "DONE"
        }
    }
    
    var color: Color {
        switch self {
        case .todo:
            return Color("customRed")
        case .doing:
            return Color("customGray")
        case .done:
            return Color("customGreen")
        }
    }
    
    var image: String {
        switch self {
        case .todo:
            return "circle"
        case .doing:
            return "circle.circle"
        case .done:
            return "circle.inset.filled"
        }
    }
}
