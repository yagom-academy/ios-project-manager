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
    
    private let mockData = [
        Todo(mode: .todo, title: "책상정리", description: "집중이 안되요\n집중집중\nㅇㅇㅇasdasdasdasdasd", date: "2021.03.06"),
        Todo(mode: .done, title: "dddss", description: "집중이 안되요\nssssasdasdasd\nddasdasdasdasd", date: "2021.02.06"),
        Todo(mode: .doing, title: "asdasd", description: "집중이 안되요asdasdasdads\nasdasdasd", date: "2021.01.06"),
        Todo(mode: .todo, title: "책qwe", description: "집중이 안되요\nssss\nvvv", date: "2021.12.06")
    ]
    
    init() {
        self.tableViewData = BehaviorSubject(value: self.mockData)
        
    }
}
