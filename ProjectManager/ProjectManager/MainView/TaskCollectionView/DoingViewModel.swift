//
//  DoingViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/19.
//

import UIKit

final class DoingViewModel: TaskListViewModel {
    
    @Published var taskList: [Task] = []
    
    var taskWorkState: WorkState
    var delegate: TaskListViewModelDelegate?
    
    init(taskWorkState: WorkState, delegate: TaskListViewModelDelegate? = nil) {
        self.taskWorkState = taskWorkState
        self.delegate = delegate
    }
}

extension DoingViewModel: DetailViewModelDelegate {
    func updateTaskList(for workState: WorkState) {
        
    }
    
    func updateDataSource(for workState: WorkState, itemID: UUID?) {
        
    }
}
