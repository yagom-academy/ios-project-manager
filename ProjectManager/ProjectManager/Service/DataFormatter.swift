//
//  ViewModel.swift
//  ProjectManager
//
//  Created by 고은 on 2022/03/08.
//

import Foundation

enum DataFormatter {

    static func filterTodos(by task: TodoTasks, in todos: [Todo]) -> [Todo] {
        let todos = todos.filter { todo in
            todo.task == task
        }

        return todos
    }
}
