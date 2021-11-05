//
//  TaskListViewModel.swift
//  ProjectManager
//
//  Created by 김준건 on 2021/11/05.
//

import SwiftUI

protocol TaskListViewModelProtocol {
    var tasks: [TLTask] { get set }
    func fetchTasks()

}

final class TaskListViewModel: ObservableObject {
    @Published var tasks: [TLTask] = []
    private var dataManager: DataManagerProtocol
    
    init(dataManager: DataManagerProtocol = DataManager.shared) {
        self.dataManager = dataManager
        fetchTasks()
    }
}

extension TaskListViewModel: TaskListViewModelProtocol {
    func fetchTasks() {
        tasks = dataManager.fetchTask
    }
}

