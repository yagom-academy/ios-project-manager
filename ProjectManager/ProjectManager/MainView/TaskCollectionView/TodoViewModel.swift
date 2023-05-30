//
//  TaskCollectionViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/19.
//

import Combine

final class TodoViewModel: TaskListViewModel {
    enum TodoSection: Hashable {
        case todo(count: Int)
    }
    
    typealias Section = TodoSection
    
    var sectionInfo: TodoSection {
        TodoSection.todo(count: taskList.count)
    }
    
    var taskList: [Task] = [] {
        didSet {
            currentTaskSubject.send((taskList, isUpdating))
        }
    }
    let currentTaskSubject = PassthroughSubject<([Task], Bool), Never>()
    let taskWorkState: WorkState = .todo
    var delegate: TaskListViewModelDelegate?
    
    private var isUpdating: Bool = false
}

extension TodoViewModel: DetailViewModelDelegate {
    func setState(isUpdating: Bool) {
        self.isUpdating = isUpdating
    }
}

