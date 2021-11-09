//
//  ProjectModel.swift
//  ProjectManager
//
//  Created by 이예원 on 2021/11/02.
//

import Foundation

struct ProjectModel: Identifiable {
    var id: String = UUID().uuidString
    let title: String
    let description: String
    let date: Date
}

enum TaskStatus: CaseIterable, CustomStringConvertible {
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
}

