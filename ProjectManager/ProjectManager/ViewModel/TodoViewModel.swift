//
//  TodoViewModel.swift
//  ProjectManager
//
//  Created by bonf on 2022/09/20.
//

import RxSwift

final class TodoViewModel: ViewModelType {    
    
    struct Input {
        let doneAction: Observable<Project>
        let editAction: Observable<Project>
        let changeStatusAction: Observable<(UUID, Status)>
        let deleteAction: Observable<UUID>
    }

    struct Output {
        var projectList: Observable<[Project]>
    }
    // MARK: - properties
    
    let provider = TodoProvider.shared
    let disposeBag = DisposeBag()
    
    func transform(_ input: Input) -> Output {
        let projectList = BehaviorSubject<[Project]>(value: [])
        
        resetProjectList(projectList: projectList)
        
        input.doneAction
            .bind(onNext: { [weak self] project in
                self?.provider.saveData(project: project)
                self?.resetProjectList(projectList: projectList)
            })
            .disposed(by: disposeBag)
        
        input.editAction
            .bind(onNext: { [weak self] project in
                self?.provider.updateData(project: project)
                self?.resetProjectList(projectList: projectList)
            })
            .disposed(by: disposeBag)
        
        input.changeStatusAction
            .bind(onNext: { [weak self] (id, status) in
                guard var selectedProject = self?.selectProject(id: id, projectList: projectList) else { return }
                selectedProject.status = status
                self?.provider.updateData(project: selectedProject)
                self?.resetProjectList(projectList: projectList)
            })
            .disposed(by: disposeBag)
        
        input.deleteAction
            .bind(onNext: { [weak self] id in
                guard let selectedProject = self?.selectProject(id: id, projectList: projectList) else { return }
                self?.provider.deleteData(project: selectedProject)
                self?.resetProjectList(projectList: projectList)
            })
            .disposed(by: disposeBag)
        
        return Output(projectList: projectList)
    }
}
