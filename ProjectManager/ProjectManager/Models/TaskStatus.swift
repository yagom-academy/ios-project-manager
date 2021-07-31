//
//  TaskStatus.swift
//  ProjectManager
//
//  Created by Fezravien on 2021/07/26.
//

import Foundation

enum State {
    case todo
    case doing
    case done
}

enum History: CustomStringConvertible {
    case added(title: String)
    case moved(title: String, at: State, to: State)
    case updated(atTitle: String, toTitle: String, from: State)
    case deleted(title: String, from: State)
    
    var description: String {
        switch self {
        case .added(title: let addTitle):
            return "Added '\(addTitle)'"
        case .moved(title: let moveTitle, at: let atState, to: let toState):
            return "Moved '\(moveTitle)' from \(atState) to \(toState)"
        case .updated(atTitle: let updateAtTitle, toTitle: let updatedTitle, from: let fromState):
            return "Updated '\(updateAtTitle)' to '\(updatedTitle)' from \(fromState)"
        case .deleted(title: let deleteTitle, from: let fromState):
            return "Deleted '\(deleteTitle)' from \(fromState)"
        }
    }
}
