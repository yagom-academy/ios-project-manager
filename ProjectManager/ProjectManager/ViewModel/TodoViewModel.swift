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
        
        return TodoViewOutput(todoList: projectList)
    }
    
    func resetProjectList(status: Status) {
        let projects = provider.testProjects.filter { $0.status == status }
        projectList.onNext(projects)
    }
}

struct TodoViewInput {
    let addAction: Observable<Project>
    let updateAction: Observable<Project>
}

struct TodoViewOutput {
    var todoList: Observable<[Project]>
    var updateAction: Observable<Void>?
}
