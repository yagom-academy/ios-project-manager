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
