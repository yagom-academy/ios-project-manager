//
//  TodoListViewModel.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation
import Combine

protocol TodoListViewModelInput {
    func viewDidLoad()
    func didTapAddButton()
    func didTapHistoryButton()
}

protocol TodoListViewModelOutput {
    var isNetworkConnected: AnyPublisher<String, Never> { get }
    var title: Just<String> { get }
    
    var showErrorAlert: PassthroughSubject<String, Never> { get }
    var showCreateView: PassthroughSubject<Void, Never> { get }
    var showEditView: PassthroughSubject<Todo, Never> { get }
    var showHistoryView: PassthroughSubject<Void, Never> { get }
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
    
    var title: Just<String> {
        return Just("Project Manager")
    }
    
    let showErrorAlert = PassthroughSubject<String, Never>()
    let showEditView = PassthroughSubject<Todo, Never>()
    let showHistoryView = PassthroughSubject<Void, Never>()
    let showCreateView = PassthroughSubject<Void, Never>()
    
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
        todoUseCase.synchronizeDatabase()
    }
    
    func didTapAddButton() {
        showCreateView.send()
    }
    
    func didTapHistoryButton() {
        showHistoryView.send(())
    }
}

extension TodoListViewModel: TodoViewModelInput {
    func deleteItem(_ item: Todo) {
        deleteTodoItem(item)
        
        let historyItem = TodoHistory(title: "[삭제] \(item.title)", createdAt: Date())
        createHistoryItem(historyItem)
    }
    
    func didTapCell(_ item: Todo) {
        showEditView.send(item)
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
                self.showErrorAlert.send(error.localizedDescription)
            }, receiveValue: {}
        )
        .store(in: &cancellableBag)
    }
    
    private func deleteTodoItem(_ item: Todo) {
        todoUseCase.delete(item: item)
            .sink(
                receiveCompletion: {
                    guard case .failure(let error) = $0 else { return}
                    self.showErrorAlert.send(error.localizedDescription)
                }, receiveValue: {}
            )
            .store(in: &cancellableBag)
    }
    
    private func createHistoryItem(_ item: TodoHistory) {
        historyUseCase.create(item)
            .sink(
                receiveCompletion: {
                    guard case .failure(let error) = $0 else { return}
                    self.showErrorAlert.send(error.localizedDescription)
                }, receiveValue: {}
            )
            .store(in: &cancellableBag)
    }
}
