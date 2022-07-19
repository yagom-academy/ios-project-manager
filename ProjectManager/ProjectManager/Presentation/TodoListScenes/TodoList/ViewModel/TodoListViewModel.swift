//
//  TodoListViewModel.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Combine
import UIKit

protocol TodoListViewModelInput {
    func didTapAddButton()
    func didTapHistoryButton(sourceView: UIBarButtonItem)
}

protocol TodoListViewModelOutput {
    var isNetworkConnected: AnyPublisher<String, Never> { get }
    var title: Just<String> { get }
    var errorOccur: PassthroughSubject<Result<Void, StorageError>, Never> { get }
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
    
    var errorOccur = PassthroughSubject<Result<Void, StorageError>, Never>()
    
    private weak var coordinator: TodoListViewCoordinator?
    private let todoUseCase: TodoListUseCaseable
    private let historyUseCase: TodoHistoryUseCaseable
    private var cancelBag = Set<AnyCancellable>()
    
    init(coordinator: TodoListViewCoordinator? = nil,
         todoUseCase: TodoListUseCaseable,
         historyUseCase: TodoHistoryUseCaseable
    ) {
        self.coordinator = coordinator
        self.todoUseCase = todoUseCase
        self.historyUseCase = historyUseCase
    }
}

extension TodoListViewModel {
    
    // MARK: - Input
    
    func didTapAddButton() {
        let item = Todo.empty()
        
        todoUseCase.create(item)
            .print()
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

        coordinator?.showDetailViewController(item)
    }
    
    func didTapHistoryButton(sourceView: UIBarButtonItem) {
        coordinator?.showHistoryViewController(sourceView: sourceView)
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
    }
    
    func didTapCell(_ item: Todo) {
        coordinator?.showDetailViewController(item)
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
    }
}
