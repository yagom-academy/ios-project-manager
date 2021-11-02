//
//  TodoListViewModel.swift
//  ProjectManager
//
//  Created by YongHoon JJo on 2021/11/02.
//

import Foundation

class TodoListViewModel: ObservableObject {
    @Published var todos: [TodoViewModel] = []
    
    func load() {
        generateMockTodos()
    }
    
    private func generateMockTodos() {
        self.todos = Todo.generateMockTodos().map(TodoViewModel.init)
    }
}
