//
//  Todo.swift
//  ProjectManager
//
//  Created by tae hoon park on 2021/11/01.
//

import Foundation

struct Todo: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var date: Date
    var type: SortType
}

enum SortType: CustomStringConvertible {
    case toDo
    case doing
    case done

    var description: String {
        switch self {
        case .toDo:
            return "TODO"
        case .doing:
            return "DOING"
        case .done:
            return "DONE"
        }
    }
}
