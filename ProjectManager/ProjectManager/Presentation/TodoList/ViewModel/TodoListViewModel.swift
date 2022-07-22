//
//  TodoListViewModel.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/07.
//

import Foundation
import RxSwift
import RxCocoa

protocol TodoListViewModelInput {
    func cellSelected(id: UUID) -> TodoModel?
    func cellLongPress(id: UUID) -> TodoModel?
    func cellDeleteButtonDidTap(item: TodoCellContent)
}

protocol TodoListViewModelOutput {
    var todoList: Observable<[TodoCellContent]> { get }
    var doingList: Observable<[TodoCellContent]> { get }
    var doneList: Observable<[TodoCellContent]> { get }
    var todoListCount: Driver<String> { get }
    var doingListCount: Driver<String> { get }
    var doneListCount: Driver<String> { get }
    var errorMessage: Observable<String> { get }
}

protocol TodoListViewModel: TodoListViewModelInput, TodoListViewModelOutput {}

final class DefaultTodoListViewModel {
    private let useCase: TodoListUseCase
    private let todoLists: BehaviorSubject<[TodoModel]>
    
    init(useCase: TodoListUseCase) {
        self.useCase = useCase
        
        todoLists = useCase.readItems()
    }
    
    private func toTodoCellContents(todoModels: [TodoModel]) -> [TodoCellContent] {
        todoModels.map { item in
            TodoCellContent(entity: item, isPast: useCase.checkDeadline(time: item.deadlineAt))
        }
    }
    
    private func splitList(by state: State) -> Observable<[TodoCellContent]> {
        todoLists.map { items in
            items.filter { $0.state == state }
        }
        .distinctUntilChanged()
        .withUnretained(self)
        .map { (self, items) in
            self.toTodoCellContents(todoModels: items)
        }
    }
}

extension DefaultTodoListViewModel: TodoListViewModel {
    //MARK: - Output
    var todoList: Observable<[TodoCellContent]> {
        splitList(by: .todo)
    }

    var doingList: Observable<[TodoCellContent]> {
        splitList(by: .doing)
    }
    
    var doneList: Observable<[TodoCellContent]> {
        splitList(by: .done)
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
    
    var errorMessage: Observable<String> {
        useCase.errorObserver
            .map { error in
                error.rawValue
            }
    }
    
    //MARK: - Input
    
    func cellSelected(id: UUID) -> TodoModel? {
        return try? todoLists.value()
            .first { $0.id == id }
    }
    
    func cellLongPress(id: UUID) -> TodoModel? {
        return try? todoLists.value()
            .first(where: { $0.id == id })
    }
    
    func cellDeleteButtonDidTap(item: TodoCellContent) {
        useCase.deleteItem(id: item.id)
    }
}
