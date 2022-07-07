//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/06.
//

import RxSwift
import RxRelay
import RxCocoa

class MainViewModel {
    var projects: BehaviorRelay<[ProjectContent]> {
        return MockStorageManager.shared.projectEntity
    }
    
    var todoProjects: Driver<[ProjectContent]> {
        projects
            .map { $0.filter { $0.status == .todo } }
            .asDriver(onErrorJustReturn: [])
    }
    
    var doingProjects: Driver<[ProjectContent]> {
        projects
            .map { $0.filter { $0.status == .doing } }
            .asDriver(onErrorJustReturn: [])
    }
    
    var doneProjects: Driver<[ProjectContent]> {
        projects
            .map { $0.filter { $0.status == .done } }
            .asDriver(onErrorJustReturn: [])
    }
}
