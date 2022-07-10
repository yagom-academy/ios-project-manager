//
//  TodoListViewModel.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/07.
//

import Foundation
import RxSwift

protocol TodoListViewModelInput {
    var listItems: BehaviorSubject<[TodoModel]> { get }
}

protocol TodoListViewModelOutput {
    var todoList: Observable<[TodoModel]> { get }
    var doingList: Observable<[TodoModel]> { get }
    var doneList: Observable<[TodoModel]> { get }
}

protocol TodoListViewModel: TodoListViewModelInput, TodoListViewModelOutput {}

final class DefaultTodoListViewModel: TodoListViewModel {
    #if DEBUG
    let listItems = BehaviorSubject<[TodoModel]>(value: TodoModel.makeDummy())
    #else
    let listItems = BehaviorSubject<[TodoModel]>(value: [])
    #endif
    
    let todoList: Observable<[TodoModel]>
    
    let doingList: Observable<[TodoModel]>
    
    let doneList: Observable<[TodoModel]>
    
    init() {
        todoList = listItems
            .map { items in
                items.filter { $0.state == .todo }
            }
        
        doingList = listItems
            .map { items in
                items.filter { $0.state == .doing }
            }
        
        doneList = listItems
            .map { items in
                items.filter { $0.state == .done }
            }
    }
}
