//
//  TodoListRowViewModel.swift
//  ProjectManager
//
//  Created by Kiwon Song on 2022/09/26.
//

import SwiftUI

class TodoListRowViewModel: ObservableObject {
    @Published var todo: Todo
    @Published var statusChanging: Bool = false
    @Published var showingSheet: Bool = false
    @Published var index: Int
    
    init(todo: Todo, index: Int) {
        self.todo = todo
        self.index = index
    }
    
    func changeStatus(status: Status, dataManager: DataManager, index: Int) {
        let id = dataManager.fetch()[index].id
        
        dataManager.changeStatus(id: id, to: status)
        statusChanging.toggle()
    }
}
