//
//  TodoViewModel.swift
//  ProjectManager
//
//  Created by bonf on 2022/09/20.
//

import RxSwift

final class TodoViewModel: ViewModelType {
    
    // MARK: - properties
    
    let provider = TodoProvider.shared
    
    var projectList = BehaviorSubject<[Project]>(value: [])
    let disposeBag = DisposeBag()
    
    init() {
        resetProjectList(status: .todo)
    }
    
    func transform(_ input: TodoViewInput) -> TodoViewOutput {
        input.addAction
            .bind(onNext: { [weak self] project in
                self?.provider.saveData(project: project)
                self?.resetProjectList(status: .todo)
            })
            .disposed(by: disposeBag)
        
        input.updateAction
            .bind(onNext: { [weak self] project in
                self?.provider.updateData(project: project)
                self?.resetProjectList(status: .todo)
            })
            .disposed(by: disposeBag)
        
        input.changeStatusAction
            .bind(onNext: { [weak self] (id, status) in
                guard var selectedProject = self?.selectProject(id: id) else { return }
                selectedProject.status = status
                self?.provider.updateData(project: selectedProject)
                self?.resetProjectList(status: .todo)
            })
            .disposed(by: disposeBag)
        
        input.deleteAction
            .bind(onNext: { [weak self] id in
                guard let selectedProject = self?.selectProject(id: id) else { return }
                self?.provider.deleteData(project: selectedProject)
                self?.resetProjectList(status: .todo)
            })
            .disposed(by: disposeBag)
        
        return TodoViewOutput(todoList: projectList)
    }
}

struct TodoViewInput {
    let addAction: Observable<Project>
    let updateAction: Observable<Project>
    let changeStatusAction: Observable<(UUID, Status)>
    let deleteAction: Observable<UUID>
}

struct TodoViewOutput {
    var todoList: Observable<[Project]>
}
