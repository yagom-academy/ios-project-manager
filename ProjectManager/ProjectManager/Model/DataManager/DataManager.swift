//
//  DataManager.swift
//  ProjectManager
//
//  Created by Hemg on 2023/09/27.
//

import Foundation

protocol DataManagerProtocol {
    func addTodoItem(title: String, body: String, date: Date)
    func deleteTodoItem(_ item: ProjectManager)
}

final class DataManager: DataManagerProtocol {
    private var todoItems = [ProjectManager]()
    
    func addTodoItem(title: String, body: String, date: Date) {
        let newItem = ProjectManager(title: title, body: body, date: date)
        todoItems.append(newItem)
    }
    
    func deleteTodoItem(_ item: ProjectManager) {
        if let index = todoItems.firstIndex(where: { $0 == item }) {
            todoItems.remove(at: index)
        }
    }
}
