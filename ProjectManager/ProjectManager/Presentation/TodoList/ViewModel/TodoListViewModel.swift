//
//  TodoListViewModel.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/07.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

struct TodoListViewModelActions {
    let presentEditViewController: (_ item: TodoModel?) -> Void
}

protocol TodoListViewModelInput {
    func plusButtonDidTap()
    func cellSelected(id: UUID)
}

protocol TodoListViewModelOutput {
    var todoList: Observable<[TodoCellContent]> { get }
    var doingList: Observable<[TodoCellContent]> { get }
    var doneList: Observable<[TodoCellContent]> { get }
    var todoListCount: Driver<String> { get }
    var doingListCount: Driver<String> { get }
    var doneListCount: Driver<String> { get }
}

protocol TodoListViewModel: TodoListViewModelInput, TodoListViewModelOutput {}

final class DefaultTodoListViewModel: TodoListViewModel {
    private let useCase: UseCase
    private let actions: TodoListViewModelActions?
    private let todoLists: BehaviorSubject<[TodoModel]>
    
    //MARK: - Output
    var todoList: Observable<[TodoCellContent]> {
        todoLists.map { items in
            items.filter { $0.state == .todo }
        }
        .distinctUntilChanged { $0 == $1 }
        .map { items in
            items.map { TodoCellContent(title: $0.title,
                                        body: $0.body,
                                        deadlineAt: $0.deadlineAt.toString(self.dateFormatter),
                                        id: $0.id) }
        }
    }
    
    var doingList: Observable<[TodoCellContent]> {
        todoLists.map { items in
            items.filter { $0.state == .doing }
        }
        .distinctUntilChanged { $0 == $1 }
        .map { items in
            items.map { TodoCellContent(title: $0.title,
                                        body: $0.body,
                                        deadlineAt: $0.deadlineAt.toString(self.dateFormatter),
                                        id: $0.id) }
        }
    }
    var doneList: Observable<[TodoCellContent]> {
        todoLists.map { items in
            items.filter { $0.state == .done }
        }
        .distinctUntilChanged { $0 == $1 }
        .map { items in
            items.map { TodoCellContent(title: $0.title,
                                        body: $0.body,
                                        deadlineAt: $0.deadlineAt.toString(self.dateFormatter),
                                        id: $0.id) }
        }
    }
    
    var todoListCount: Driver<String> {
        todoList
            .map { "\($0.count)" }
            .asDriver(onErrorJustReturn: "0")
    }
    var doingListCount: Driver<String> {
        doingList
            .map { "\($0.count)" }
            .asDriver(onErrorJustReturn: "0")
    }
    var doneListCount: Driver<String> {
        doneList
            .map { "\($0.count)" }
            .asDriver(onErrorJustReturn: "0")
    }
    
    //MARK: - Input
    func plusButtonDidTap() {
        actions?.presentEditViewController(nil)
    }
    
    func cellSelected(id: UUID) {
        let item = try? useCase.readRepository().value()
            .first { $0.id == id }
        actions?.presentEditViewController(item)
        
    }
    
    init(useCase: UseCase, actions: TodoListViewModelActions) {
        self.useCase = useCase
        self.actions = actions
        
        todoLists = useCase.readRepository()
    }
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. d"
        return dateFormatter
    }()
    
    private func toTodoCellContents(todoModels: [TodoModel]) -> [TodoCellContent] {
        todoModels.map { item in
            TodoCellContent(title: item.title,
                            body: item.body,
                            deadlineAt: item.deadlineAt.toString(dateFormatter),
                            id: item.id)
        }
    }
}

struct TodoCellContent {
    let title: String?
    let body: String?
    let deadlineAt: String
    let id: UUID
}
