//
//  TodoList.swift
//  ProjectManager
//
//  Created by 고은 on 2022/03/02.
//

import Foundation

class TodoList {

    private var todoList: [TodoTasks: [Todo]] = {
        var todoList = [TodoTasks: [Todo]]()
        TodoTasks.allCases.forEach { task in
            todoList.updateValue([Todo](), forKey: task)
        }

        return todoList
    }()

    func remove(todo: Todo, at task: TodoTasks) {
        guard let deleteTodoIndex = self.searchIndex(of: todo, at: task) else {
            return
        }

        self.todoList[task]?.remove(at: deleteTodoIndex)
    }

    func add(todo: Todo, at task: TodoTasks) {
        self.todoList[task]?.append(todo)
    }

    func editTask(todo: Todo, at newTask: TodoTasks, originalTask: TodoTasks) {
        self.remove(todo: todo, at: originalTask)
        self.add(todo: todo, at: newTask)
    }

    func update(todo: Todo, at task: TodoTasks, originalTodo: Todo) {
        guard let index = self.searchIndex(of: originalTodo, at: task) else {
            return
        }

        self.todoList[task]?[index] = todo
    }

    func fetch(completionHandler: @escaping ([TodoTasks: [Todo]]) -> Void) {
        completionHandler(self.todoList)
    }

    private func searchIndex(of todo: Todo, at task: TodoTasks) -> Int? {
        let todoIndex = self.todoList[task]?.firstIndex { someTodo in
            someTodo.uuid == todo.uuid
        }

        return todoIndex
    }
}
