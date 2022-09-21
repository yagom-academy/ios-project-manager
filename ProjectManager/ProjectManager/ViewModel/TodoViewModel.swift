//
//  AllTodoViewModel.swift
//  ProjectManager
//
//  Created by bonf on 2022/09/20.
//

import RxSwift

final class TodoViewModel: ViewModelType {
    
    // MARK: - properties
    
    let todoList = BehaviorSubject<[Project]>(value: [])
    
    init() {
        
    }
}
