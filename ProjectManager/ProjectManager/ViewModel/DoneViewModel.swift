//
//  DoneViewModel.swift
//  ProjectManager
//
//  Created by bonf on 2022/09/19.
//

import RxSwift

final class DoneViewModel: ViewModelType {
    
    // MARK: - properties
    
    var todoList = BehaviorSubject<[Project]>(value: [])
}
