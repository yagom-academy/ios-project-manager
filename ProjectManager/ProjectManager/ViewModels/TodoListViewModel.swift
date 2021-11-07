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
    
    func addTodo(_ todoFormVM: TodoFormViewModel) {
        let todo = Todo(title: todoFormVM.title,
                        description: todoFormVM.description,
                        dueDate: todoFormVM.dueDate,
                        status: .todo)
        todos.append(TodoViewModel(todo: todo))
    }
    
    func updateTodo(_ todoFormlVM: TodoFormViewModel) {
        let todo = Todo(title: todoFormlVM.title,
                        description: todoFormlVM.description,
                        dueDate: todoFormlVM.dueDate,
                        status: .todo)
        todos = todos.map { $0.id == todoFormlVM.id ? TodoViewModel(todo: todo) : $0 }
    }
    
    func deleteTodo(at id: String) {
        todos = todos.filter { $0.id != id }
    }
}
