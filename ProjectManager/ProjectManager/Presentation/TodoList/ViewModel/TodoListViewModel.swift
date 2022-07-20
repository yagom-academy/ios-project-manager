//
//  TodoListViewModel.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/07.
//

import Foundation
import RxSwift
import RxCocoa

struct TodoListViewModelActions {
    let presentEditViewController: (_ item: TodoModel?) -> Void
    let popoverMoveViewController: (_ cell: TodoListCell?, _ item: TodoModel) -> Void
    let showErrorAlert: (_ message: String) -> Void
}

protocol TodoListViewModelInput {
    func plusButtonDidTap()
    func cellSelected(id: UUID)
    func cellLongPress(cell: TodoListCell?, id: UUID)
    func cellDeleteButtonDidTap(item: TodoCellContent)
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

final class DefaultTodoListViewModel {
    private let useCase: TodoListUseCase
    private let actions: TodoListViewModelActions?
    private let todoLists: BehaviorSubject<[TodoModel]>
    private let bag = DisposeBag()
    
    init(useCase: TodoListUseCase, actions: TodoListViewModelActions) {
        self.useCase = useCase
        self.actions = actions
        
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
    
    //MARK: - Input
    func plusButtonDidTap() {
        actions?.presentEditViewController(nil)
    }
    
    func cellSelected(id: UUID) {
        let item = try? todoLists.value()
            .first { $0.id == id }
        actions?.presentEditViewController(item)
    }
    
    func cellLongPress(cell: TodoListCell?, id: UUID) {
        if let item = try? todoLists.value()
            .first(where: { $0.id == id }) {
                actions?.popoverMoveViewController(cell, item)
        }
    }
    
    func cellDeleteButtonDidTap(item: TodoCellContent) {
        useCase.deleteItem(id: item.id)
            .subscribe(onError: { [weak self] _ in
                self?.actions?.showErrorAlert("삭제 오류")
            }).disposed(by: bag)
    }
}
