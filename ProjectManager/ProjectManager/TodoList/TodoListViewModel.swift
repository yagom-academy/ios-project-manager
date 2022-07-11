//
//  TodoListViewModel.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/05.
//

import Foundation
import TodoListViewModel_Fixture

import RxCocoa
import RxRelay
import RxSwift

final class TodoListViewModel {
    let todoViewData: Driver<[Todo]>
    let doingViewData: Driver<[Todo]>
    let doneViewData: Driver<[Todo]>

    let dataBase: DataBase = MockDataBase()
    
    init() {
        let data = BehaviorRelay<[Todo]>(value: dataBase.read())
            
        todoViewData = data
            .map { $0.filter { $0.status == .todo } }
            .asDriver(onErrorJustReturn: [])
        
        doingViewData = data
            .map { $0.filter { $0.status == .doing } }
            .asDriver(onErrorJustReturn: [])
        
        doneViewData = data
            .map { $0.filter { $0.status == .done } }
            .asDriver(onErrorJustReturn: [])
    }
}

protocol DataBase {
    func read() -> [Todo]
}

fileprivate struct MockDataBase: DataBase {
    let data1 = MockData().data
    let data2 = MockData().data2
    let data3 = MockData().data3
    
    func read() -> [Todo] {
        let status1 = data1["status"]
        let title1 = data1["title"]
        let description1 = data1["description"]
        
        let status2 = data2["status"]
        let title2 = data2["title"]
        let description2 = data2["description"]
        
        let status3 = data3["status"]
        let title3 = data3["title"]
        let description3 = data3["description"]
        
        let data: [Todo] = [
            Todo(status: Status(rawValue: status1!)!, title: title1!, description: description1!, date: Date()),
            Todo(status: Status(rawValue: status2!)!, title: title2!, description: description2!, date: Date()),
            Todo(status: Status(rawValue: status3!)!, title: title3!, description: description3!, date: Date())
        ]
        return data
    }
}
