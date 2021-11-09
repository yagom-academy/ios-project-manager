//
//  TodoViewModel.swift
//  ProjectManager
//
//  Created by Yongwoo Marco on 2021/10/28.
//

import Foundation

final class TodoViewModel: ObservableObject {
    @Published var todoList: TodoList = TodoList(todoList: [])
    
    func eachStateTodoList(_ state: TodoList.Completion) -> [Todo] {
        todoList[state]
    }
    
    func addTodo(title: String, endDate: Date, detail: String) {
        todoList.addTodo(title, endDate, detail)
    }
    
    func deleteTodo(_ todo: Todo) {
        todoList.deleteTodo(todo)
    }
    
    func editTodo(baseTodo todo: Todo, title: String, endDate: Date, detail: String) {
        todoList.editTodo(base: todo, title, endDate, detail)
    }
    
    func changeTodoState(baseTodo todo: Todo, to changedState: TodoList.Completion) {
        todoList.changeTodoState(base: todo, to: changedState)
    }
}
