//
//  TodoListViewModel.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation
import Combine
import SwiftUI

protocol TodoListViewModelInput {
    func viewDidLoad()
    func didTapAddButton()
    func didTapHistoryButton()
}

protocol TodoListViewModelOutput {
    var isNetworkConnected: AnyPublisher<String, Never> { get }
    
    var state: PassthroughSubject<TodoListViewModel.State, Never> { get }
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
    
    var todoItems: AnyPublisher<[Todo], Never> {
        return todoUseCase.read().eraseToAnyPublisher()
    }
    
    var historyItems: AnyPublisher<[TodoHistory], Never> {
        return historyUseCase.read().eraseToAnyPublisher()
    }

    enum State {
        case viewTitleEvent(title: String)
        case errorEvent(message: String)
        case showEditViewEvent(item: Todo)
        case showHistoryViewEvent
        case showCreateViewEvent
    }
    
    let state = PassthroughSubject<State, Never>()
    
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
        deleteTodoItem(item)
        
        let historyItem = TodoHistory(title: "[삭제] \(item.title)", createdAt: Date())
        createHistoryItem(historyItem)
    }
    
    func didTapCell(_ item: Todo) {
        state.send(.showEditViewEvent(item: item))
    }
    
    func didTapFirstContextMenu(_ item: Todo) {
        updateTodoItem(item)
        
        let historyItem = TodoHistory(title: "[수정] \(item.title)", createdAt: Date())
        createHistoryItem(historyItem)
    }
    
    func didTapSecondContextMenu(_ item: Todo) {
        updateTodoItem(item)
        
        let historyItem = TodoHistory(title: "[수정] \(item.title)", createdAt: Date())
        createHistoryItem(historyItem)
    }
    
    private func updateTodoItem(_ item: Todo) {
        todoUseCase.update(item)
        .sink(
            receiveCompletion: {
                guard case .failure(let error) = $0 else { return}
                self.state.send(.errorEvent(message: error.localizedDescription))
            }, receiveValue: {}
        )
        .store(in: &cancellableBag)
    }
    
    private func deleteTodoItem(_ item: Todo) {
        todoUseCase.delete(item: item)
            .sink(
                receiveCompletion: {
                    guard case .failure(let error) = $0 else { return}
                    self.state.send(.errorEvent(message: error.localizedDescription))
                }, receiveValue: {}
            )
            .store(in: &cancellableBag)
    }
    
    private func createHistoryItem(_ item: TodoHistory) {
        historyUseCase.create(item)
            .sink(
                receiveCompletion: {
                    guard case .failure(let error) = $0 else { return}
                    self.state.send(.errorEvent(message: error.localizedDescription))
                }, receiveValue: {}
            )
            .store(in: &cancellableBag)
    }
}
