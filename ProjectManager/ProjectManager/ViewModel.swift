//
//  ViewModel.swift
//  ProjectManager
//
//  Created by bonf on 2022/09/11.
//

import RxSwift

struct ViewModel {
    
    // MARK: - properties

    let todoList = BehaviorSubject<[Project]>(value: [])
    let doingList = BehaviorSubject<[Project]>(value: [])
    let doneList = BehaviorSubject<[Project]>(value: [])
    
    // MARK: - functions

    func appendProject(project: Project) {
        todoList.onNext([project])
    }
}
