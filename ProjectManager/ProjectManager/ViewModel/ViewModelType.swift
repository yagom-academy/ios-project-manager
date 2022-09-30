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
    
    func resetProjectList()
}

extension ViewModelType {
    func transform(_ input: TodoViewInput) -> TodoViewOutput {
        input.addAction
            .bind(onNext: { project in
                provider.saveData(project: project)
                resetProjectList()
            })
            .disposed(by: disposeBag)
        
        input.updateAction
            .bind(onNext: { project in
                provider.updateData(project: project)
                resetProjectList()
            })
            .disposed(by: disposeBag)
        
        input.changeStatusAction
            .bind(onNext: { (id, status) in
                guard var selectedProject = selectProject(id: id) else { return }
                selectedProject.status = status
                provider.updateData(project: selectedProject)
                resetProjectList()
            })
            .disposed(by: disposeBag)
        
        input.deleteAction
            .bind(onNext: { id in
                guard let selectedProject = selectProject(id: id) else { return }
                provider.deleteData(project: selectedProject)
                resetProjectList()
            })
            .disposed(by: disposeBag)
        
        return TodoViewOutput(projectList: projectList)
    }
    
    func resetProjectList() {
        provider.allProjectList.bind(onNext: { projectList in
            self.projectList.onNext(projectList)
        })
        .disposed(by: disposeBag)
    }
    
    func selectProject(id: UUID) -> Project? {
        guard let projects = try? projectList.value() else { return nil }
        let selectedProject = projects.filter { $0.uuid == id }
        
        return selectedProject.first
    }
}
