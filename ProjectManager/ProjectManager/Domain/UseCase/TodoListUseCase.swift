//
//  TodoListUseCase.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/08.
//

import Foundation
import RxSwift
import RxRelay

protocol TodoListUseCase {
    func readItems() -> BehaviorSubject<[TodoModel]>
    func readHistoryItems() -> BehaviorSubject<[History]>
    func createItem(to data: TodoModel)
    func updateItem(to item: TodoModel)
    func deleteItem(id: UUID)
    func firstMoveState(item: TodoModel)
    func secondMoveState(item: TodoModel)
    var errorObserver: PublishRelay<TodoError> { get }
}

final class DefaultTodoListUseCase {
    private let listRepository: TodoListRepository
    private let historyRepository: HistoryRepository
    
    init(listRepository: TodoListRepository, historyRepository: HistoryRepository) {
        self.listRepository = listRepository
        self.historyRepository = historyRepository
    }
    
    private func changTodoItemState(item: TodoModel, to state: State) {
        var revisedItem = item
        revisedItem.state = state
        listRepository.update(to: revisedItem)
        let historyItem = History(changes: .moved,
                                  title: item.title ?? "",
                                  beforeState: item.state,
                                  afterState: revisedItem.state)
        historyRepository.save(to: historyItem)
    }
}

extension DefaultTodoListUseCase: TodoListUseCase {
    var errorObserver: PublishRelay<TodoError> {
        listRepository.errorObserver
    }

    func readItems() -> BehaviorSubject<[TodoModel]> {
        return listRepository.read()
    }
    
    func readHistoryItems() -> BehaviorSubject<[History]> {
        return historyRepository.read()
    }
    
    func createItem(to item: TodoModel) {
        let historyItem = History(changes: .added,
                                  title: item.title ?? "")
        historyRepository.save(to: historyItem)
        listRepository.create(to: item)
    }
    
    func updateItem(to item: TodoModel) {
        listRepository.update(to: item)
    }
    
    func deleteItem(id: UUID) {
        guard let items = try? listRepository.read().value(),
              let index = items.firstIndex(where: { $0.id == id }) else {
            errorObserver.accept(TodoError.unknownItem)
            return
        }
        let historyItem = History(changes: .removed,
                                  title: items[index].title ?? "",
                                  beforeState: items[index].state)
        historyRepository.save(to: historyItem)
        listRepository.delete(index: index)
    }
    
    func firstMoveState(item: TodoModel) {
        switch item.state {
        case .todo:
            changTodoItemState(item: item, to: .doing)
        case .doing:
            changTodoItemState(item: item, to: .todo)
        case .done:
            changTodoItemState(item: item, to: .todo)
        }
    }
    
    func secondMoveState(item: TodoModel) {
        switch item.state {
        case .todo:
            changTodoItemState(item: item, to: .done)
        case .doing:
            changTodoItemState(item: item, to: .done)
        case .done:
            changTodoItemState(item: item, to: .doing)
        }
    }
}
