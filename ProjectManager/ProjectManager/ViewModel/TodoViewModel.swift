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
        provider.allTodoData.subscribe(onNext: { [weak self] projects in
            let todoProjects = projects.filter { $0.status == .todo }
            self?.projectList.onNext(todoProjects)
        })
        .disposed(by: disposeBag)
    }
    
    func transform(_ input: TodoViewInput) -> TodoViewOutput {
        input.addButtonAction
            .bind(onNext: { [weak self] project in
                self?.provider.saveData(project: project)
            })
            .disposed(by: disposeBag)
        return TodoViewOutput(todoList: projectList)
    }
}

struct TodoViewInput {
    let addButtonAction: Observable<Project>
}

struct TodoViewOutput {
    var todoList: Observable<[Project]>
}
