//
//  DoingViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/19.
//

import UIKit
import Combine

final class DoingViewModel: TaskListViewModel {
    var taskList: [Task] = [] {
        didSet {
            currentTaskSubject.send(taskList)
        }
    }
    let currentTaskSubject = CurrentValueSubject<[Task], Never>([])
    var taskWorkState: WorkState = .doing
    var delegate: TaskListViewModelDelegate?
}

extension DoingViewModel: DetailViewModelDelegate { }
