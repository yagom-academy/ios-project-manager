//
//  MockListRepository.swift
//  ProjectManagerTests
//
//  Created by 이시원 on 2022/07/29.
//

import Foundation
import RxSwift
@testable import ProjectManager

class MockListRepository: TodoListRepository {
    var errorObserver: Observable<TodoError> = .just(.saveError)
    
    private let storage = BehaviorSubject<[TodoModel]>(value: [])
    
    func read() -> BehaviorSubject<[TodoModel]> {
        return storage
    }
    
    func create(to data: TodoModel) {
        let items = try! storage.value()
        storage.onNext(items +  [data])
    }
    
    func update(to data: TodoModel) {
        var items = try! storage.value()
        let index = items.firstIndex { $0.id == data.id }!
        items[index] = data
        storage.onNext(items)
    }
    
    func delete(index: Int) {
        var items = try! storage.value()
        items.remove(at: index)
        storage.onNext(items)
    }
}
