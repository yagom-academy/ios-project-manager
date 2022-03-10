//
//  ViewModel.swift
//  ProjectManager
//
//  Created by 고은 on 2022/03/08.
//

import Foundation

// Refactoring MVC to MVVM 시도

struct DataFormatter {
    func filterTodos(by section: TodoSection, in todos: [Todo]) -> [Todo] {
        let todos = todos.filter { todo in
            todo.section == section
        }

        return todos
    }
}
