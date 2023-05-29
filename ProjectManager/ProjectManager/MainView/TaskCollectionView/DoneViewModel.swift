//
//  DoneViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/19.
//

import UIKit
import Combine

final class DoneViewModel: TaskListViewModel {
    var taskList: [Task] = [] {
        didSet {
            currentTaskSubject.send(taskList)
        }
    }
    let currentTaskSubject = CurrentValueSubject<[Task], Never>([])
    var taskWorkState: WorkState = .done
    var delegate: TaskListViewModelDelegate?
}

extension DoneViewModel: DetailViewModelDelegate { }
