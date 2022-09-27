//
//  TodoListViewModel.swift
//  ProjectManager
//
//  Created by Kiwi on 2022/09/26.
//

import SwiftUI

final class TodoListViewModel {
    let status: Status
    
    init(status: Status) {
        self.status = status
    }
    
    func countTodoData(dataManager: TodoDataManager) -> Int {
            return dataManager.fetch(by: status).count
        }
    
    func fetchTodoData(dataManager: TodoDataManager) -> [Todo] {
           return dataManager.fetch(by: status)
       }

    func removeData(dataManager: TodoDataManager, indexSet: IndexSet) {
        let data = dataManager.fetch(by: status)
        guard let index = indexSet.first else { return }
        
        let id = data[index].id
        dataManager.delete(id: id)
    }
}
