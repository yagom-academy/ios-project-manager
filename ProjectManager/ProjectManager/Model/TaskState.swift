//
//  WorkState.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/02.
//

import Foundation

enum TaskState {
    case waiting
    case progress
    case done
    
    var title: String {
        switch self {
        case .waiting:
            return "TODO"
        case .progress:
            return "DOING"
        case .done:
            return "DONE"
        }
    }
    
    var relocation: String {
        switch self {
        case .waiting:
            return "Move to TODO"
        case .progress:
            return "Move to DOING"
        case .done:
            return "Move to DONE"
        }
    }
}
