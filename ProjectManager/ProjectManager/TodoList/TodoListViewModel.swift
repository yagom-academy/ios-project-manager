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
    
    let mockData = [Todo(title: "책상정리", description: "집중이 안되요", date: "2021.03.06")]
    
    init() {
        self.tableViewData = BehaviorSubject(value: mockData)
    }
}
