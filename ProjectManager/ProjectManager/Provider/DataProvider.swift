//
//  DataProvider.swift
//  ProjectManager
//
//  Created by 고은 on 2022/03/03.
//

import Foundation

class DataProvider {

    var updated: () -> Void = {}
    private var updatedTodoList = [Todo]() {
        didSet {
            updated()
        }
    }
    private let todoList = TodoList()

    func reload() {
        todoList.fetch { [weak self] list in
            guard let self = self else {
                return
            }
            self.updatedTodoList = list
        }
    }

    func updatedList() -> [Todo] {
        self.updatedTodoList
    }

    func update(todo: Todo, in section: TodoSection) {
        self.todoList.add(todo: todo, in: section)
        self.reload()
    }

    func delete(todo: Todo) {
        self.todoList.remove(at: todo)
        self.reload()
    }
}
