//
//  TodoListViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/17.
//

import Foundation

final class TodoListViewModel {
    let todoList: [Todo] = [
        Todo(title: "hi", date: Date(), body: "body", workState: .todo),
        Todo(title: "hiThere", date: Date(), body: "body", workState: .done),
        Todo(title: "hi", date: Date(), body: "body", workState: .doing),
        Todo(title: "hibye", date: Date(), body: "body", workState: .todo),
        Todo(title: "hibyehi", date: Date(), body: "body", workState: .todo)
    ]
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
