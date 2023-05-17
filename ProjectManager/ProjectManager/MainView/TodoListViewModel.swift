//
//  TodoListViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/17.
//

import Foundation

final class TodoListViewModel {
    let todoList: [Todo] = Array(repeating: Todo(title: "hi", date: Date(), body: "body"), count: 20)
}

extension TodoListViewModel {
    var numberOfRowsInSection: Int {
        return self.todoList.count
    }
    
    func todo(at index: Int) -> TodoViewModel? {
        guard let todo = todoList[safe: index] else {
            return nil
        }
        
        return TodoViewModel(todo: todo)
    }
}
