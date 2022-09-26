//
//  ViewModelType.swift
//  ProjectManager
//
//  Created by bonf on 2022/09/19.
//

import RxSwift

protocol ViewModelType {
    var provider: TodoProvider { get }
    var projectList: BehaviorSubject<[Project]> { get set }
}
