//
//  PlanViewModel.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/17.
//

import UIKit
import Combine

final class PlanViewModel {
    @Published private(set) var todoItems: [TodoItem] = []
    @Published private(set) var doingItems: [TodoItem] = []
    @Published private(set) var doneItems: [TodoItem] = []
    private(set) var state: State?
    private(set) var currentLongPressedCell: PlanTableViewCell?
    
    var numberOfItems: Int {
        switch state {
        case .todo:
            return todoItems.count
        case .doing:
            return doingItems.count
        default:
            return doneItems.count
        }
    }
    
    func item(at index: Int) -> TodoItem {
        switch state {
        case .todo:
            return todoItems[index]
        case .doing:
            return doingItems[index]
        default:
            return doneItems[index]
        }
    }
    
    func addItem(_ item: TodoItem) {
        switch state {
        case .todo:
            todoItems.append(item)
        case .doing:
            doingItems.append(item)
        default:
            doneItems.append(item)
        }
    }
    
    func updateItem(at index: Int, newItem: TodoItem) {
        todoItems[index] = newItem
    }
    
    func delete(at index: Int) {
        switch state {
        case .todo:
            todoItems.remove(at: index)
        case .doing:
            doingItems.remove(at: index)
        default:
            doneItems.remove(at: index)
        }
    }
    
    func updateState(_ newState: State) {
        state = newState
    }
    
    func updateCurrentCell(_ cell: PlanTableViewCell) {
        currentLongPressedCell = cell
    }
}
