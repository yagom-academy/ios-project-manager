//
//  DataManager.swift
//  ProjectManager
//
//  Created by Hemg on 2023/09/27.
//

import Foundation

final class DataManager {
    static let shared = DataManager()
    private var todoItems = [ProjectManager]()
    private init() {}
    
    func addTodoItem(title: String, body: String, date: Date) {
        let newItem =  ProjectManager(title: title, body: body, date: date)
        todoItems.append(newItem)
    }
    
    func leadTodoItem() -> [ProjectManager] {
        return todoItems
    }
}
