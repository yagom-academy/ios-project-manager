//
//  ViewModelType.swift
//  ProjectManager
//
//  Created by bonf on 2022/09/19.
//

import RxSwift

protocol ViewModelType {
    
    associatedtype Input
    associatedtype Output
    
    var provider: TodoProvider { get }
    var disposeBag: DisposeBag { get }
    
    func resetProjectList(projectList: BehaviorSubject<[Project]>)
}

extension ViewModelType {
    
    func resetProjectList(projectList: BehaviorSubject<[Project]>) {
        provider.allProjectList.bind(onNext: { projects in
            projectList.onNext(projects)
        })
        .disposed(by: disposeBag)
    }

    func selectProject(id: UUID, projectList: BehaviorSubject<[Project]>) -> Project? {
        guard let projects = try? projectList.value() else { return nil }
        let selectedProject = projects.filter { $0.uuid == id }
        
        return selectedProject.first
    }
}
