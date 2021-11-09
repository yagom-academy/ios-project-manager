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
    subscript(_ state: Completion) -> [Todo] {
        todoList.filter{ $0.completionState == state }
    }
}

// MARK: - Mutating Methods
extension TodoList {
    mutating func addTodo(_ todo: Todo) {
        todoList.append(todo)
    }
    
    mutating func deleteTodo(_ todo: Todo) {
        guard let foundIndex = todoList.firstIndex(where: { $0.id == todo.id }) else {
            NSLog("해당 Todo를 찾을 수 없음")
            return
        }
        todoList.remove(at: foundIndex)
    }
    
    mutating func editTodo(_ editedTodo: Todo) {
        guard let foundIndex = todoList.firstIndex(where: { $0.id == editedTodo.id }) else {
            NSLog("해당 Todo를 찾을 수 없음")
            return
        }
        todoList[foundIndex] = editedTodo
    }
    
    mutating func changeTodoState(_ todo: Todo, to ChangedState: Completion) {
        guard let foundIndex = todoList.firstIndex(where: { $0.id == todo.id }) else {
            NSLog("해당 Todo를 찾을 수 없음")
            return
        }
        todoList[foundIndex].completionState = ChangedState
    }
}
