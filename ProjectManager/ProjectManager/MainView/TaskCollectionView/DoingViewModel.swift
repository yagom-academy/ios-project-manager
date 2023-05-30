//
//  DoingViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/19.
//

import Combine

final class DoingViewModel: TaskListViewModel {
    enum DoingSection: Hashable {
        case doing(count: Int)
    }
    
    typealias Section = DoingSection
    
    var sectionInfo: DoingSection {
        DoingSection.doing(count: taskList.count)
    }
    
    var taskList: [Task] = [] {
        didSet {
            currentTaskSubject.send((taskList, isUpdating))
        }
    }
    let currentTaskSubject = PassthroughSubject<([Task], Bool), Never>()
    var taskWorkState: WorkState = .doing
    var delegate: TaskListViewModelDelegate?
    
    private var isUpdating: Bool = false
}

extension DoingViewModel: DetailViewModelDelegate {
    func setState(isUpdating: Bool) {
        self.isUpdating = isUpdating
    }
}
