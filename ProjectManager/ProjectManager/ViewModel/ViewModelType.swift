//
//  ViewModelType.swift
//  ProjectManager
//
//  Created by bonf on 2022/09/19.
//

import RxSwift

protocol ViewModelType {
    var provider: TodoProvider { get }
    var projectList: BehaviorSubject<[Project]> { get set }
    var disposeBag: DisposeBag { get }
    
    func resetProjectList(status: Status)
}

extension ViewModelType {
    func resetProjectList(status: Status) {
        provider.allProjectList.bind(onNext: { projectList in
            let projects = projectList.filter { $0.status == status }
            self.projectList.onNext(projects)
        })
        .disposed(by: disposeBag)
    }
    
    func selectProject(id: UUID) -> Project? {
        guard let projects = try? projectList.value() else { return nil }
        let selectedProject = projects.filter { $0.uuid == id }
        
        return selectedProject.first
    }
}
