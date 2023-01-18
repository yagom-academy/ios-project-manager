//
//  ProjectManagerViewModel.swift
//  ProjectManager
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation
import RxSwift

// TODO: Create ViewModel
final class ProjectManagerViewModel {
    private var tasks: [Task] = []
    let subject: BehaviorSubject<[Task]>
    
    init() {
        self.subject = BehaviorSubject(value: tasks)
    }
    func addTask(task: Task) {
        tasks.append(task)
        subject.onNext(tasks)
    }
}
