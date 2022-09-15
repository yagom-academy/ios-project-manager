//
//  ViewModel.swift
//  ProjectManager
//
//  Created by bonf on 2022/09/11.
//

import RxSwift

struct ViewModel {
    
    // MARK: - properties

    private var projects: [Project] = [] {
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

    mutating func appendProject(project: Project) {
        projects.append(project)
    }
}
