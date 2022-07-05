//
//  TodoListViewModel.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/05.
//

import Foundation

import RxSwift

final class TodoListViewModel {
    let tableViewData: BehaviorSubject<[Todo]>?
    
    init() {
        self.tableViewData = BehaviorSubject(value: [Todo(identifier: UUID(), title: "eee", description: "eee", date: Date())])
    }
}
