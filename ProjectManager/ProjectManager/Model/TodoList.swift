//
//  TodoList.swift
//  ProjectManager
//
//  Created by Yongwoo Marco on 2021/11/09.
//

import Foundation

struct TodoList {
    enum Completion: Int, CaseIterable, CustomStringConvertible {
        case todo = 1
        case doing
        case done
        
        var description: String {
            switch self {
            case .todo:
                return "TODO"
            case .doing:
                return "DOING"
            case .done:
                return "DONE"
            }
        }
    }
    
    private(set) var todoList: [Todo]
}

// MARK: - Mutating Methods
extension TodoList {
    mutating func addTodo(_ title: String, _ endDate: Date, _ detail: String) {
        let convertedDate = endDate.timeIntervalSince1970
        let newTodo = Todo(title: title, detail: detail, endDate: convertedDate, completionState: Completion.todo.rawValue)
        todoList.append(newTodo)
    }
    
    mutating func deleteTodo(_ todo: Todo) {
        guard let firstIndex = todoList.firstIndex(of: todo) else {
            NSLog("해당 Todo를 찾을 수 없음")
            return
        }
        todoList.remove(at: firstIndex)
    }
    
    mutating func editTodo(base todo: Todo, _ title: String, _ endDate: Date, _ detail: String) {
        guard let firstIndex = todoList.firstIndex(of: todo) else {
            NSLog("해당 Todo를 찾을 수 없음")
            return
        }
        let editedTodo = Todo(title: title, detail: detail,
                              endDate: endDate.timeIntervalSince1970,
                              completionState: todo.completionState)
        todoList[firstIndex] = editedTodo
    }
    
    mutating func changeTodoState(base todo: Todo, to ChangedState: Completion) {
        guard let firstIndex = todoList.firstIndex(of: todo) else {
            NSLog("해당 Todo를 찾을 수 없음")
            return
        }
        let editedTodo = Todo(title: todo.title, detail: todo.detail,
                              endDate: todo.endDate,
                              completionState: ChangedState.rawValue)
        todoList[firstIndex] = editedTodo
    }
}
