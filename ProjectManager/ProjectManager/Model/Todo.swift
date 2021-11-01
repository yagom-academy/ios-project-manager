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
    var dueDate: Date
    var type: SortType
}

enum SortType {
    case todo
    case doing
    case done
}
