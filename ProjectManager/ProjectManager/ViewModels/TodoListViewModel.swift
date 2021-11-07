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
    
    func addTodo(_ todoModalVM: TodoModalViewModel) {
        let todo = Todo(title: todoModalVM.title,
                        description: todoModalVM.description,
                        dueDate: todoModalVM.dueDate,
                        status: .todo)
        todos.append(TodoViewModel(todo: todo))
    }
    
    func updateTodo(_ todoModalVM: TodoModalViewModel) {
        let todo = Todo(title: todoModalVM.title,
                        description: todoModalVM.description,
                        dueDate: todoModalVM.dueDate,
                        status: .todo)
        todos = todos.map { $0.id == todoModalVM.id ? TodoViewModel(todo: todo) : $0 }
    }
}
