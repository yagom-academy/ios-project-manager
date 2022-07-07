//
//  TodoListViewModel.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/07.
//

import Foundation
import RxSwift

protocol TodoListViewModelInput {
    var listItems: BehaviorSubject<[TodoMedel]> { get }
}

protocol TodoListViewModelOutput {
    var todoList: Observable<[TodoMedel]> { get }
    var doingList: Observable<[TodoMedel]> { get }
    var doneList: Observable<[TodoMedel]> { get }
}

protocol TodoListViewModel: TodoListViewModelInput, TodoListViewModelOutput {}

final class DefaultTodoListViewModel: TodoListViewModel {
    let listItems = BehaviorSubject<[TodoMedel]>(value: TodoMedel.makeDummy())
    
    private(set) lazy var todoList = listItems
        .map { items in
            items.filter { $0.state == .todo }
        }
    
    private(set) lazy var doingList = listItems
        .map { items in
            items.filter { $0.state == .doing }
        }
    
    private(set) lazy var doneList = listItems
        .map { items in
            items.filter { $0.state == .done }
        }
}
