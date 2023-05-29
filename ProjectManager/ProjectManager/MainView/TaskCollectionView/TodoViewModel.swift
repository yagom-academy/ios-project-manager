//
//  TaskCollectionViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/19.
//

import UIKit
import Combine

final class TodoViewModel: TaskListViewModel {
    var taskList: [Task] = [] {
        didSet {
            currentTaskSubject.send(taskList)
        }
    }
    let currentTaskSubject = CurrentValueSubject<[Task], Never>([])
    let taskWorkState: WorkState = .todo
    var delegate: TaskListViewModelDelegate?
}

extension TodoViewModel: DetailViewModelDelegate { }

