//
//  DoingViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/19.
//

import Combine

final class DoingViewModel: TaskListViewModel {
    var taskList: [Task] = [] {
        didSet {
            currentTaskSubject.send((taskList, isUpdating))
        }
    }
    let currentTaskSubject = PassthroughSubject<([Task], Bool), Never>()
    var taskWorkState: WorkState = .doing
    var delegate: TaskListViewModelDelegate?
    
    private var isUpdating: Bool = false
    
    func setState(isUpdating: Bool) {
        self.isUpdating = isUpdating
    }
}

extension DoingViewModel: DetailViewModelDelegate { }
