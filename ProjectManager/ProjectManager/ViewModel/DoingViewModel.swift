//
//  DoingViewModel.swift
//  ProjectManager
//
//  Created by bonf on 2022/09/19.
//

import RxSwift

final class DoingViewModel: ViewModelType {
    
    // MARK: - properties
    
    let todoList = BehaviorSubject<[Project]>(value: [])
}
