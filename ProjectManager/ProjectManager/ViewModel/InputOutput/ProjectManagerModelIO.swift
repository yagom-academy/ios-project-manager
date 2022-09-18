//
//  ProjectManagerModel.swift
//  ProjectManager
//
//  Created by Finnn on 2022/09/18.
//

import RxSwift

// MARK: - ProjectManager ViewModel <-> CollectionCell ViewModels (1 : 3)

struct ProjectManagerModelInput {
    var saveAction: Observable<Todo?>?
    var deleteAction: Observable<Todo>?
    var moveToAction: Observable<Todo>?
}

struct ProjectManagerModelOutput {
    var allTodoList: Observable<[Todo]>?
    var error: Observable<Error>?
}
