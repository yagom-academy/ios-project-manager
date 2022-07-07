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
    let projects = BehaviorRelay<[ProjectContent]>(value: [])
    
    var todoProjects: Driver<[ProjectContent]>
    var doingProjects: Driver<[ProjectContent]>
    var doneProjects: Driver<[ProjectContent]>
    
    init() {
        let content = MockStorageManager.shared.read()
            .map {
            ProjectContent($0)
        }
        
        projects.accept(content)
        
        todoProjects = projects
            .map {
               $0.filter { $0.status == ProjectStatus.todo }
            }
            .asDriver(onErrorJustReturn: [])
        
        doingProjects = projects
            .map {
               $0.filter { $0.status == ProjectStatus.doing }
            }
            .asDriver(onErrorJustReturn: [])
        
        doneProjects = projects
            .map {
               $0.filter { $0.status == ProjectStatus.done }
            }
            .asDriver(onErrorJustReturn: [])
    }
}
