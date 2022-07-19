//
//  TodoListViewModel.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Combine

protocol TodoListViewModelInput {
    func didTapAddButton()
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
    
    var items: AnyPublisher<[Todo], Never> {
        return useCase.read().eraseToAnyPublisher()
    }
    
    var title: Just<String> {
        return Just("Project Manager")
    }
    
    var errorOccur = PassthroughSubject<Result<Void, StorageError>, Never>()
    
    private weak var coordinator: TodoListViewCoordinator?
    private let useCase: TodoListUseCaseable
    private var cancelBag = Set<AnyCancellable>()
    
    init(coordinator: TodoListViewCoordinator? = nil, useCase: TodoListUseCaseable) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
}

extension TodoListViewModel {
    
    // MARK: - Input
    
    func didTapAddButton() {
        let item = Todo.empty()
        
        useCase.create(item)
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
}

extension TodoListViewModel: TodoViewModelInput {
    func deleteItem(_ item: Todo) {
        useCase.delete(item: item)
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
        useCase.update(item)
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
        useCase.update(item)
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
