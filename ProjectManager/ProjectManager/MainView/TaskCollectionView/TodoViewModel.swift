//
//  TaskCollectionViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/19.
//

import UIKit

final class TodoViewModel: TaskListViewModel {
    @Published var taskList: [Task] = []
    var taskListPublisher: Published<[Task]>.Publisher { $taskList }
    let taskWorkState: WorkState = .todo
    var delegate: TaskListViewModelDelegate?
}

extension TodoViewModel: DetailViewModelDelegate {
    func updateTaskList(for workState: WorkState) {
        
    }
    
    func updateDataSource(for workState: WorkState, itemID: UUID?) {
        
    }
}

