//
//  ToDo.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/10/28.
//

import Foundation

enum ToDoStatus {
    case toDo
    case doing
    case done
}

struct ToDo {
    var title: String
    var description: String
    var date: String
    var status: ToDoStatus = .toDo
}


