//
//  TaskCollectionViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/19.
//

import Combine

final class TodoViewModel: TaskListViewModel {
    var taskList: [Task] = [] {
        didSet {
            currentTaskSubject.send((taskList, isUpdating))
        }
    }
    let currentTaskSubject = PassthroughSubject<([Task], Bool), Never>()
    let taskWorkState: WorkState = .todo
    var delegate: TaskListViewModelDelegate?
    
    private var isUpdating: Bool = false
    
    func setState(isUpdating: Bool) {
        self.isUpdating = isUpdating
    }
}

extension TodoViewModel: DetailViewModelDelegate { }
