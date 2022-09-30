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
}

struct TodoViewInput {
    let addAction: Observable<Project>
    let updateAction: Observable<Project>
    let changeStatusAction: Observable<(UUID, Status)>
    let deleteAction: Observable<UUID>
}

struct TodoViewOutput {
    var projectList: Observable<[Project]>
}
