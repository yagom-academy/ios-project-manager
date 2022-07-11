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
    struct Input {
        let doneButtonTapEvent: Observable<Todo>
    }
    
    struct Output {
        let dismiss: Driver<Void>
    }
    
    let todoViewData: Driver<[Todo]>
    let doingViewData: Driver<[Todo]>
    let doneViewData: Driver<[Todo]>

    let dataBase: DataBase = TestDataBase()
    
    init(dataBase: DataBase = MockDataBase()) {
        self.dataBase = dataBase
        let data = BehaviorRelay<[Todo]>(value: self.dataBase.read())
            
        self.todoViewData = data
            .map { $0.filter { $0.status == .todo } }
            .asDriver(onErrorJustReturn: [])
        
        self.doingViewData = data
            .map { $0.filter { $0.status == .doing } }
            .asDriver(onErrorJustReturn: [])
        
        self.doneViewData = data
            .map { $0.filter { $0.status == .done } }
            .asDriver(onErrorJustReturn: [])
    }
    
    func transform(input: Input) -> Output {
        let output = input.doneButtonTapEvent
            .do { self.dataBase.save(todo: $0) }
            .map { _ in }
            .asDriver(onErrorJustReturn: ())
        
        return Output(dismiss: output)
    }
}

protocol DataBase {
    func read() -> [Todo]
    mutating func save(todo: Todo)
}

fileprivate struct TestDataBase: DataBase {
    let data1 = MockData().data
    let data2 = MockData().data2
    let data3 = MockData().data3
    
    private var todoList: [Todo] = []
    
    init() {
        self.createMockData()
    }
    
    private mutating func createMockData() {
        let status1 = self.data1["status"]
        let title1 = self.data1["title"]
        let description1 = self.data1["description"]
        
        let status2 = self.data2["status"]
        let title2 = self.data2["title"]
        let description2 = self.data2["description"]
        
        let status3 = self.data3["status"]
        let title3 = self.data3["title"]
        let description3 = self.data3["description"]
        
        self.todoList = [
            Todo(status: Status(rawValue: status1!)!, title: title1!, description: description1!, date: Date()),
            Todo(status: Status(rawValue: status2!)!, title: title2!, description: description2!, date: Date()),
            Todo(status: Status(rawValue: status3!)!, title: title3!, description: description3!, date: Date())
        ]
    }
    
    func read() -> [Todo] {
        return todoList
    }
    
    mutating func save(todo: Todo) {
        self.todoList.append(todo)
    }
}
