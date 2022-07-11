//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/06.
//

import RxSwift
import RxRelay
import RxCocoa

struct MainViewModel {
    let projects: BehaviorRelay<[ProjectContent]> = {
        return MockStorageManager.shared.read()
    }()
    
    lazy var todoProjects: Driver<[ProjectContent]> = {
        projects
            .map { $0.filter { $0.status == .todo } }
            .asDriver(onErrorJustReturn: [])
    }()
    
    lazy var doingProjects: Driver<[ProjectContent]> = {
        projects
            .map { $0.filter { $0.status == .doing } }
            .asDriver(onErrorJustReturn: [])
    }()
    
    lazy var doneProjects: Driver<[ProjectContent]> = {
        projects
            .map { $0.filter { $0.status == .done } }
            .asDriver(onErrorJustReturn: [])
    }()
}
