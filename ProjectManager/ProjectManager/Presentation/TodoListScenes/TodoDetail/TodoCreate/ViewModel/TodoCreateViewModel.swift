//
//  TodoCreateViewModel.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/19.
//

import Combine
import Foundation

enum TodoCreateViewModelState {
    case dismissEvent
    case errorEvent(message: String)
}

protocol TodoCreateViewModelInput {
    func didTapCancelButton()
    func didTapDoneButton(_ title: String?, _ content: String?, _ deadline: Date?)
}

protocol TodoCreateViewModelOutput {
    var state: PassthroughSubject<TodoCreateViewModelState, Never> { get }
}

protocol TodoCreateViewModelable: TodoCreateViewModelInput, TodoCreateViewModelOutput {}

final class TodoCreateViewModel: TodoCreateViewModelable {
    
    // MARK: - Output
        
    let state = PassthroughSubject<TodoCreateViewModelState, Never>()

    private let todoUseCase: TodoListUseCaseable
    private let historyUseCase: TodoHistoryUseCaseable
    private var cancellableBag = Set<AnyCancellable>()
    
    init(todoUseCase: TodoListUseCaseable, historyUseCase: TodoHistoryUseCaseable) {
        self.todoUseCase = todoUseCase
        self.historyUseCase = historyUseCase
    }
}

extension TodoCreateViewModel {
    
    // MARK: - Input
    
    func didTapCancelButton() {
        state.send(.dismissEvent)
    }
    
    func didTapDoneButton(_ title: String?, _ content: String?, _ deadline: Date?) {
        guard let title = title, let content = content, let deadline = deadline else {
            return
        }
        
        let todoItem = Todo(title: title, content: content, deadline: deadline)
        createTodoItem(todoItem)
        
        let historyItem = TodoHistory(title: "[생성] \(todoItem.title)", createdAt: Date())
        createHistoryItem(historyItem)
        
        state.send(.dismissEvent)
    }
    
    private func createTodoItem(_ item: Todo) {
        todoUseCase.create(item)
    }
    
    private func createHistoryItem(_ item: TodoHistory) {
        historyUseCase.create(item)
    }
}
