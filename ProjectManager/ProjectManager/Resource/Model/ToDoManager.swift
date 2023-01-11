//
//  ToDoManager.swift
//  ProjectManager
//
//  Created by 로빈솜 on 2023/01/11.
//

import Foundation

class ToDoManager: ToDoManageable {
    var toDoList = [ToDo]()

    func create() -> ToDo {
        let toDo = ToDo(id: UUID(), title: "", description: "", deadline: Date())

        return toDo
    }

    func fetch(id: UUID) -> ToDo? {
        return toDoList.filter { $0.id == id }.first
    }

    func save(id: UUID, title: String, description: String, deadline: Date) {
        guard var toDo = fetch(id: id) else { return }

        toDo.title = title
        toDo.description = description
        toDo.deadline = deadline

        toDoList.append(toDo)
    }

    func delete(id: UUID) {
//        let number = toDoList.filter { $0.id == id }
//        return toDoList.remove(at: number)
    }

}
