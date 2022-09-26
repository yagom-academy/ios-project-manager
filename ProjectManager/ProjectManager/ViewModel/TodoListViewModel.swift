//
//  TodoListViewModel.swift
//  ProjectManager
//
//  Created by Kiwon Song on 2022/09/26.
//

import SwiftUI

class TodoListViewModel: ObservableObject {
    let status: Status
    
    init(status: Status) {
        self.status = status
    }
    
    func countTodoData(dataManager: DataManager) -> Int {
        switch status {
        case .todo:
            return dataManager.todoData.filter { $0.status == .todo }.count
        case .doing:
            return dataManager.todoData.filter { $0.status == .doing }.count
        case .done:
            return dataManager.todoData.filter { $0.status == .done }.count
        }
    }
    
    func fetchTodoData(dataManager: DataManager) -> [Todo] {
        switch status {
        case .todo:
            return dataManager.todoData.filter { $0.status == .todo }
        case .doing:
            return dataManager.todoData.filter { $0.status == .doing }
        case .done:
            return dataManager.todoData.filter { $0.status == .done }
        }
    }
    
    func removeData(dataManager: DataManager, indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        
        let id = dataManager.fetch()[index].id
        dataManager.delete(id: id)
    }
}
