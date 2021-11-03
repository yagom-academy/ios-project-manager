//
//  Todo.swift
//  ProjectManager
//
//  Created by tae hoon park on 2021/11/01.
//

import Foundation

struct Todo: Identifiable {
    let id: UUID
    var title: String
    var description: String
    var date: Date
    var type: SortType
    
    init(id: UUID = UUID(), title: String, description: String, date: Date, type: SortType) {
        self.id = id
        self.title = title
        self.description = description
        self.date = date
        self.type = type
    }
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
