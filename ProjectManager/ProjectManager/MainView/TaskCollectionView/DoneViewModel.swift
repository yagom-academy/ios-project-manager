//
//  DoneViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/19.
//

import UIKit

final class DoneViewModel: TaskListViewModel {
    @Published var taskList: [Task] = []
    
    var taskWorkState: WorkState = .done
    var delegate: TaskListViewModelDelegate?
}

extension DoneViewModel: DetailViewModelDelegate {
    func updateTaskList(for workState: WorkState) {
        
    }
    
    func updateDataSource(for workState: WorkState, itemID: UUID?) {
        
    }
}
