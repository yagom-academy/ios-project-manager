//
//  Process.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/13.
//

import Foundation

enum Process: Int, CaseIterable {
    case todo = 0, doing, done
    
    var title: String {
        switch self {
        case .todo:
            return "TODO"
        case .doing:
            return "DOING"
        case .done:
            return "DONE"
        }
    }
    
    var index: Int {
        return rawValue
    }
    
    var movingOption: [String: Process] {
        switch self {
        case .todo:
            return ["Move to DOING": .doing, "Move to DONE": .done]
        case .doing:
            return ["Move to TODO": .todo, "Move to DONE": .done]
        case .done:
            return ["Move to TODO": .todo, "Move to DOING": .doing]
        }
    }
}
