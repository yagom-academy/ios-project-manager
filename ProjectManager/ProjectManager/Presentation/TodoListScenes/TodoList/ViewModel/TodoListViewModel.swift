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
    var errorOccur: PassthroughSubject<Result<Void, StorageError>, Never> { get }
    
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
    
    let errorOccur = PassthroughSubject<Result<Void, StorageError>, Never>()
    
    let showEditView = PassthroughSubject<Todo, Never>()
    let showHistoryView = PassthroughSubject<Void, Never>()
    let showCreateView = PassthroughSubject<Void, Never>()
    
    private let todoUseCase: TodoListUseCaseable
    private let historyUseCase: TodoHistoryUseCaseable
    private var cancelBag = Set<AnyCancellable>()
    
    init(todoUseCase: TodoListUseCaseable, historyUseCase: TodoHistoryUseCaseable) {
        self.todoUseCase = todoUseCase
        self.historyUseCase = historyUseCase
    }
}

extension TodoListViewModel {
    
    // MARK: - Input
    
    func viewDidLoad() {
        todoUseCase.synchronize()
    }
    
    func didTapAddButton() {
        showCreateView.send()
    }
}

extension TodoListViewModel: TodoViewModelInput {
    func deleteItem(_ item: Todo) {
        todoUseCase.delete(item: item)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.errorOccur.send(.success(()))
                case .failure(let error):
                    self?.errorOccur.send(.failure(error))
                }
            } receiveValue: { _ in
                
            }
            .store(in: &cancelBag)
        
        let historyItem = TodoHistory(title: "[삭제] \(item.title)", createdAt: Date())
        _ = historyUseCase.create(historyItem)
    }
    
    func didTapHistoryButton() {
        showHistoryView.send(())
    }
    
    func didTapCell(_ item: Todo) {
        showEditView.send(item)
    }
    
    func didTapFirstContextMenu(_ item: Todo) {
        todoUseCase.update(item)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.errorOccur.send(.success(()))
                case .failure(let error):
                    self?.errorOccur.send(.failure(error))
                }
            } receiveValue: { _ in
                
            }
            .store(in: &cancelBag)
        
        let historyItem = TodoHistory(title: "[수정] \(item.title)", createdAt: Date())
        _ = historyUseCase.create(historyItem)
    }
    
    func didTapSecondContextMenu(_ item: Todo) {
        todoUseCase.update(item)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.errorOccur.send(.success(()))
                case .failure(let error):
                    self?.errorOccur.send(.failure(error))
                }
            } receiveValue: { _ in
                
            }
            .store(in: &cancelBag)
        
        let historyItem = TodoHistory(title: "[수정] \(item.title)", createdAt: Date())
        _ = historyUseCase.create(historyItem)
    }
}
