//
//  ProjectManagerViewModel.swift
//  ProjectManager
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation
import RxSwift

// TODO: Create ViewModel
final class ProjectManagerViewModel {
    let taskItems = PublishSubject<[Task]>()
    
    func addTask(task: [Task]) {
        taskItems.onNext(task)
    }
}
