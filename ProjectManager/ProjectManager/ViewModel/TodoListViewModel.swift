//
//  TodoListViewModel.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/17.
//

import UIKit
import Combine

final class TodoListViewModel {
    @Published private(set) var todoItems: [TodoItem] = []
    
    var numberOfItems: Int {
        return todoItems.count
    }
    
    func item(at index: Int) -> TodoItem {
        return todoItems[index]
    }
    
    func addItem(_ item: TodoItem) {
        todoItems.append(item)
    }
    
    func updateItem(at index: Int, newItem: TodoItem) {
        todoItems[index] = newItem
    }
    
    func delete(at index: Int) {
        todoItems.remove(at: index)
    }
}
