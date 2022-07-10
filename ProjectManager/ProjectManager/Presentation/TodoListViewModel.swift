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
    var todoListCount: Observable<String> { get }
    var doingListCount: Observable<String> { get }
    var doneListCount: Observable<String> { get }
}

protocol TodoListViewModel: TodoListViewModelInput, TodoListViewModelOutput {
    func toTodoCellContents(todoModels: [TodoModel]) -> [TodoCellContent]
}

final class DefaultTodoListViewModel: TodoListViewModel {
    #if DEBUG
    let listItems = BehaviorSubject<[TodoModel]>(value: TodoModel.makeDummy())
    #else
    let listItems = BehaviorSubject<[TodoModel]>(value: [])
    #endif
    
    let todoList: Observable<[TodoModel]>
    let doingList: Observable<[TodoModel]>
    let doneList: Observable<[TodoModel]>
    let todoListCount: Observable<String>
    let doingListCount: Observable<String>
    let doneListCount: Observable<String>
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. d"
        return dateFormatter
    }()
    
    init() {
        todoList = listItems
            .map { items in
                items.filter { $0.state == .todo }
            }
        
        todoListCount = todoList
            .map({ "\($0.count)" })
        
        doingList = listItems
            .map { items in
                items.filter { $0.state == .doing }
            }
        
        doingListCount = doingList
            .map({ "\($0.count)" })
        
        doneList = listItems
            .map { items in
                items.filter { $0.state == .done }
            }
        
        doneListCount = doneList
            .map({ "\($0.count)" })
    }
    
    func toTodoCellContents(todoModels: [TodoModel]) -> [TodoCellContent] {
        todoModels.map { item in
            TodoCellContent(title: item.title,
                            body: item.body,
                            deadlineAt: item.deadlineAt.toString(dateFormatter))
        }
    }
}

struct TodoCellContent {
    let title: String?
    let body: String?
    let deadlineAt: String?
}
