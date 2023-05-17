//
//  TodoViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/17.
//

import Foundation

final class TodoViewModel {
    private let todo: Todo
    
    init(todo: Todo) {
        self.todo = todo
    }
    
    var title: String { return todo.title }
    
    var body: String { return todo.body }
    
    var date: Date { return todo.date }
}
