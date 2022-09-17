//
//  ViewModel.swift
//  ProjectManager
//
//  Created by bonf on 2022/09/11.
//

import RxSwift

class ViewModel {
    
    // MARK: - properties

    var projects: [Project] = [] {
        didSet {
            print(projects)
            todoList?.onNext(projects)
        }
    }
    
    var todoList: BehaviorSubject<[Project]>?
    var doingList: BehaviorSubject<[Project]>?
    var doneList: BehaviorSubject<[Project]>?
    
    init() {
        todoList = BehaviorSubject<[Project]>(value: projects)
        doingList = BehaviorSubject<[Project]>(value: projects)
        doneList = BehaviorSubject<[Project]>(value: projects)
    }
    
    // MARK: - functions

    func appendProject(project: Project) {
        projects.append(project)
    }
}
