//
//  TaskStatus.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/08.
//

import Foundation

enum TaskStatus {
    case todo, doing, done
}

extension TaskStatus {
    var title: String {
        return String(describing: self).uppercased()
    }
    
    var moveToText: String {
        return "Move to \(String(describing: self).uppercased())"
    }
}

extension TaskStatus {
    var moveToStatus: [TaskStatus] {
        switch self {
        case .todo:
            return [.doing, .done]
        case .doing:
            return [.todo, .done]
        case .done:
            return [.todo, .doing]
        }
    }
}
