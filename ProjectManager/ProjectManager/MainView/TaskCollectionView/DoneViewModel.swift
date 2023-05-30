//
//  DoneViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/19.
//

import Combine

final class DoneViewModel: TaskListViewModel {
    enum DoneSection: Hashable {
        case done(count: Int)
    }
    
    typealias Section = DoneSection
    
    var sectionInfo: DoneSection {
        DoneSection.done(count: taskList.count)
    }
    
    var taskList: [Task] = [] {
        didSet {
            currentTaskSubject.send((taskList, isUpdating))
        }
    }
    let currentTaskSubject = PassthroughSubject<([Task], Bool), Never>()
    var taskWorkState: WorkState = .done
    var delegate: TaskListViewModelDelegate?
    
    private var isUpdating: Bool = false
    
    func setState(isUpdating: Bool) {
        self.isUpdating = isUpdating
    }
}

extension DoneViewModel: DetailViewModelDelegate { }
