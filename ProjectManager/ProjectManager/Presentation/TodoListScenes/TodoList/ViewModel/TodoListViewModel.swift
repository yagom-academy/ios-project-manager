//
//  TodoListViewModel.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation
import Combine

enum TodoListViewModelState {
    case viewTitleEvent(title: String)
    case errorEvent(message: String)
    case showEditViewEvent(item: Todo)
    case showHistoryViewEvent
    case showCreateViewEvent
}

protocol TodoListViewModelInput {
    func viewDidLoad()
    func didTapAddButton()
    func didTapHistoryButton()
}

protocol TodoListViewModelOutput {
    var isNetworkConnected: AnyPublisher<String, Never> { get }

    var state: PassthroughSubject<TodoListViewModelState, Never> { get }
}

protocol TodoListViewModelable: TodoListViewModelInput, TodoListViewModelOutput {}

final class TodoListViewModel: TodoListViewModelable {
    
    // MARK: - Output
    
    var isNetworkConnected: AnyPublisher<String, Never> {
        return NetworkMonitor.shared.$isConnected
            .map { isConnect in
                if isConnect {
                    return "wifi"
                } else {
                    return "wifi.slash"
                }
            }
            .eraseToAnyPublisher()
    }
    
    var todoItems: AnyPublisher<LocalStorageState, Never> {
        return todoUseCase.todosPublisher().eraseToAnyPublisher()
    }

    let state = PassthroughSubject<TodoListViewModelState, Never>()
    
    private let todoUseCase: TodoListUseCaseable
    private let historyUseCase: TodoHistoryUseCaseable
    private var cancellableBag = Set<AnyCancellable>()
    
    init(todoUseCase: TodoListUseCaseable, historyUseCase: TodoHistoryUseCaseable) {
        self.todoUseCase = todoUseCase
        self.historyUseCase = historyUseCase
    }
}

extension TodoListViewModel {
    
    // MARK: - Input
    
    func viewDidLoad() {
        state.send(.viewTitleEvent(title: "Project Manager"))
        todoUseCase.synchronizeDatabase()
    }
    
    func didTapAddButton() {
        state.send(.showCreateViewEvent)
    }
    
    func didTapHistoryButton() {
        state.send(.showHistoryViewEvent)
    }
}

extension TodoListViewModel: TodoViewModelInput {
    func deleteItem(_ item: Todo) {
        todoUseCase.delete(item: item)
        
        let historyItem = TodoHistory(title: "[삭제] \(item.title)", createdAt: Date())
        historyUseCase.create(historyItem)
    }
    
    func didTapCell(_ item: Todo) {
        state.send(.showEditViewEvent(item: item))
    }
    
    func didTapFirstContextMenu(_ item: Todo) {
        todoUseCase.update(item)
        
        let historyItem = TodoHistory(title: "[수정] \(item.title)", createdAt: Date())
        historyUseCase.create(historyItem)
    }
    
    func didTapSecondContextMenu(_ item: Todo) {
        todoUseCase.update(item)
        
        let historyItem = TodoHistory(title: "[수정] \(item.title)", createdAt: Date())
        historyUseCase.create(historyItem)
    }
}
