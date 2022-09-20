//
//  ViewModelType.swift
//  ProjectManager
//
//  Created by bonf on 2022/09/19.
//

import RxSwift

protocol ViewModelType {
    var todoList: BehaviorSubject<[Project]> { get set }
    
}
