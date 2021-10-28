//
//  ToDo.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/10/28.
//

import Foundation

let dummyToDos: [ToDo] = [
    ToDo(title: "제목 1", description: "asdf", date: "asdf"),
    ToDo(title: "제목 2", description: "asdf", date: "asdf", status: .doing),
    ToDo(title: "제목 3", description: "asdf", date: "asdf", status: .done)
]

enum ToDoStatus {
    case toDo
    case doing
    case done
}

struct ToDo: Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var date: String
    var status: ToDoStatus = .toDo
}


