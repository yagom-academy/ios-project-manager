//
//  TodoListViewModel.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/17.
//

import Foundation
import Combine

final class TodoListViewModel {
    @Published var todoItems: [TodoItem] = []
    
    var numberOfItems: Int {
        return todoItems.count
    }
    
    func item(at index: Int) -> TodoItem {
        return todoItems[index]
    }
    
    func saveTodoItem(title: String, body: String, date: Date) {
        let item = TodoItem(title: title, body: body, date: date)
        todoItems.append(item)
    }
    
}
