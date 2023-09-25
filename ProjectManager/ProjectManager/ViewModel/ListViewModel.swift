//
//  ListViewModel.swift
//  ProjectManager
//
//  Created by Moon on 2023/09/25.
//

import Foundation

final class ListViewModel {
    private let todoList = [
        Todo(title: "1", description: "111", deadline: Date()),
        Todo(title: "2", description: "222", deadline: Date()),
        Todo(title: "3", description: "333", deadline: Date()),
        Todo(title: "4", description: "444", deadline: Date()),
        Todo(title: "5", description: "555", deadline: Date()),
        Todo(title: "6", description: "666", deadline: Date())
    ]
    
    func getTodoList() -> [Todo] {
        return todoList
    }
}
