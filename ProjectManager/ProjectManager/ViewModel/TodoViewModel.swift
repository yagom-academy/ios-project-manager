//
//  TodoViewModel.swift
//  ProjectManager
//
//  Created by Yongwoo Marco on 2021/10/28.
//

import Foundation

final class TodoViewModel: ObservableObject {
    @Published var todos: [Todo] = []
    
    func addTodo(title: String, endDate: Date, detail: String) {
        let convertedDate = endDate.timeIntervalSince1970
        let newTodo = Todo(title: title, detail: detail, endDate: convertedDate, completionState: .todo)
        todos.append(newTodo)
    }
    
    func deleteTodo(_ todo: Todo) {
        guard let firstIndex = todos.firstIndex(of: todo) else {
            NSLog("해당 Todo를 찾을 수 없음")
            return
        }
        todos.remove(at: firstIndex)
    }
    
    func editTodo(baseTodo todo: Todo, title: String, endDate: Date, detail: String) {
        guard let firstIndex = todos.firstIndex(of: todo) else {
            NSLog("해당 Todo를 찾을 수 없음")
            return
        }
        let editedTodo = Todo(title: title, detail: detail,
                              endDate: endDate.timeIntervalSince1970,
                              completionState: todo.completionState)
        todos[firstIndex] = editedTodo
    }
    
    func changeCompletionState(baseTodo todo: Todo, to ChangedState: Todo.Completion) {
        guard let firstIndex = todos.firstIndex(of: todo) else {
            NSLog("해당 Todo를 찾을 수 없음")
            return
        }
        let editedTodo = Todo(title: todo.title, detail: todo.detail,
                              endDate: todo.endDate,
                              completionState: ChangedState)
        todos[firstIndex] = editedTodo
    }
}
