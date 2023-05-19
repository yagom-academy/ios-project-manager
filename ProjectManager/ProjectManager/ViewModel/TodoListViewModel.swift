//
//  TodoListViewModel.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/17.
//

import UIKit
import Combine

final class TodoListViewModel {
    @Published var todoItems: [TodoItem] = []
    
    var numberOfItems: Int {
        return todoItems.count
    }
    
    func item(at index: Int) -> TodoItem {
        return todoItems[index]
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
}
