//
//  DoneViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/19.
//

import Combine

final class DoneViewModel: TaskListViewModel {
    var taskList: [Task] = [] {
        didSet {
            currentTaskSubject.send((taskList, isUpdating))
        }
    }
    let currentTaskSubject = PassthroughSubject<([Task], Bool), Never>()
    var taskWorkState: WorkState = .done
    var delegate: TaskListViewModelDelegate?
    
    private var isUpdating: Bool = false
}

extension DoneViewModel: DetailViewModelDelegate {
    func setState(isUpdating: Bool) {
        self.isUpdating = isUpdating
    }
}
