//
//  DoneViewModel.swift
//  ProjectManager
//
//  Created by bonf on 2022/09/19.
//

import RxSwift

final class DoneViewModel: ViewModelType {
    
    // MARK: - properties
    
    let provider = TodoProvider.shared
    
    var projectList = BehaviorSubject<[Project]>(value: [])
    let disposeBag = DisposeBag()
    
    init() {
        resetProjectList(status: .done)
    }
    
    func transform(_ input: DoneViewInput) -> DoneViewOutput {
        input.updateAction
            .bind(onNext: { [weak self] project in
                self?.provider.updateData(project: project)
                self?.resetProjectList(status: .done)
            })
            .disposed(by: disposeBag)
        
        input.changeStatusAction
            .bind(onNext: { [weak self] (id, status) in
                guard var selectedProject = self?.selectProject(id: id) else { return }
                selectedProject.status = status
                self?.provider.updateData(project: selectedProject)
                self?.resetProjectList(status: .done)
            })
            .disposed(by: disposeBag)
        
        input.deleteAction
            .bind(onNext: { [weak self] id in
                guard let selectedProject = self?.selectProject(id: id) else { return }
                self?.provider.deleteData(project: selectedProject)
                self?.resetProjectList(status: .done)
            })
            .disposed(by: disposeBag)
        
        return DoneViewOutput(doneList: projectList)
    }
}

struct DoneViewInput {
    let updateAction: Observable<Project>
    let changeStatusAction: Observable<(UUID, Status)>
    let deleteAction: Observable<UUID>
}

struct DoneViewOutput {
    var doneList: Observable<[Project]>
}
