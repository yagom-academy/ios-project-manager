//
//  TodoDetailViewModel.swift
//  ProjectManager
//
//  Created by Baek on 2022/09/22.
//

import Foundation
import RxCocoa
import RxSwift

class TodoDetailViewModel {
    private var database: DatabaseManager
    
    init(database: DatabaseManager) {
        self.database = database
    }
    
    func doneButtonClick(todo: TodoModel, todoDetailType: TodoDetailType) {
        if todoDetailType == .newTodo {
            createTodo(todo: todo)
        } else {
            updateTodo(todo: todo)
        }
    }
    
    private func createTodo(todo: TodoModel) {
        self.database.create(todoData: todo)
    }
    
    private func updateTodo(todo: TodoModel) {
        self.database.update(updateTodoData: todo)
    }
}
