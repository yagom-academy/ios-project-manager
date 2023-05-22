//
//  TodoListViewModel.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/17.
//

import UIKit
import Combine

final class TodoListViewModel: ObservableObject {
    @Published var todoItems: [TodoItem] = []
    
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
    
    func convertDate(of date: Date) -> String {
        return DateFormatManager.shared.convertToFormattedDate(of: date)
    }
    
    func changeColor(at index: Int) -> UIColor {
        let item = todoItems[index]
        let result = DateFormatManager.shared.compareDate(from: item.date)
        
        switch result {
        case .past:
            return UIColor.red
        default:
            return UIColor.black
        }
    }
    
    func delete(at index: Int) {
        todoItems.remove(at: index)
    }
}
