//
//  TodoViewModel.swift
//  ProjectManager
//
//  Created by Yongwoo Marco on 2021/10/28.
//

import Foundation

final class TodoViewModel: ObservableObject {
    @Published private var todoList: TodoList = TodoList(todoList: [])
    
    func filteredList(of state: TodoList.State) -> [Todo] {
        todoList[state]
    }
    
    func addItem(_ todo: Todo) {
        todoList.addTodo(todo)
    }
    
    func deleteItem(_ todo: Todo) {
        todoList.deleteTodo(todo)
    }
    
    func editItem(_ todo: Todo) {
        todoList.editTodo(todo)
    }
    
    func changeTodoState(_ todo: Todo, to changedState: TodoList.State) {
        todoList.changeTodoState(todo, to: changedState)
    }
}
