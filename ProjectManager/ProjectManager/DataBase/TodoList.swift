//
//  TodoList.swift
//  ProjectManager
//
//  Created by 고은 on 2022/03/02.
//

import Foundation

class TodoList {

    private var todoList = [Todo]()

    @discardableResult
    func remove(at todo: Todo) -> Bool {
        let deleteNoteIndex = self.todoList.firstIndex { todo in
            todo.uuid == todo.uuid
        }

        guard let deleteNoteIndex = deleteNoteIndex else {
            return false
        }

        self.todoList.remove(at: deleteNoteIndex)

        return true
    }

    func add(Todo: Todo) {
        self.todoList.append(Todo)
    }

}
