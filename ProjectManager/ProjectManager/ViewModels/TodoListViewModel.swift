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
        self.todos = Todo.generateMockTodos().map { TodoViewModel(todo: $0) }
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
        
        guard let index = todos.firstIndex(where: { $0.id == todoFormlVM.id }) else {
            return
        }
        
        todos[index].todo = todo
    }
    
    func deleteTodo(at id: String) {
        todos = todos.filter { $0.id != id }
    }
    
    func updateStatus(of item: TodoViewModel, to status: TodoStatus) {
        let todo = Todo(title: item.title,
                        description: item.description,
                        dueDate: item.dueDate,
                        status: status)

        guard let index = todos.firstIndex(where: { $0.id == item.id }) else {
            return
        }
        
        todos[index].todo = todo
    }
}
