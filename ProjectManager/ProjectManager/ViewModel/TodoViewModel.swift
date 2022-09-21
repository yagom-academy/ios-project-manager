//
//  TodoViewModel.swift
//  ProjectManager
//
//  Created by bonf on 2022/09/20.
//

import RxSwift

final class TodoViewModel: ViewModelType {
    
    // MARK: - properties
    
    let viewModel = AllTodoViewModel()
    var todoList = BehaviorSubject<[Project]>(value: [])
    let disposeBag = DisposeBag()
    
    init() {
        viewModel.todoList
            .subscribe(onNext: { [weak self] projects in
                self?.todoList.onNext(projects)
//                print(projects)
            })
            .disposed(by: disposeBag)
    }
}
