//
//  TodoEditViewModel.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation
import Combine

enum TodoEditViewModelState {
    case itemEvent(item: Todo)
    case viewTitleEvent(title: String)
    case isEdited
    case dismissEvent
    case errorEvent(message: String)
}

protocol TodoEditViewModelInput {
    func viewDidLoad()
    func didTapDoneButton(title: String?, content: String?, deadline: Date?)
    func didTapEditButton()
}

protocol TodoEditViewModelOutput {
    var state: PassthroughSubject<TodoEditViewModelState, Never> { get }
}

protocol TodoEditViewModelable: TodoEditViewModelInput, TodoEditViewModelOutput {}

final class TodoEditViewModel: TodoEditViewModelable {
    
    // MARK: - Output
        
    let state = PassthroughSubject<TodoEditViewModelState, Never>()
    
    private let todo: Todo
    private let todoUseCase: TodoListUseCaseable
    private let historyUseCase: TodoHistoryUseCaseable
    private var cancellableBag = Set<AnyCancellable>()
    
    init(todoUseCase: TodoListUseCaseable, historyUseCase: TodoHistoryUseCaseable, item: Todo) {
        self.todoUseCase = todoUseCase
        self.historyUseCase = historyUseCase
        self.todo = item
    }
}

extension TodoEditViewModel {
    
    // MARK: - Input
    
    func viewDidLoad() {
        state.send(.viewTitleEvent(title: "TODO"))
        state.send(.itemEvent(item: todo))
    }
    
    func didTapDoneButton(title: String?, content: String?, deadline: Date?) {
        guard let title = title,
              let content = content,
              let deadline = deadline
        else {
            return
        }
        
        if title.isEmpty && content.isEmpty {
            return
        }
        
        let todoItem = Todo(
            title: title,
            content: content,
            deadline: deadline,
            processType: todo.processType,
            id: todo.id
        )
        updateTodoItem(todoItem)
        
        let historyItem = TodoHistory(title: "[수정] \(title)", createdAt: Date())
        createHistoryItem(historyItem)

        state.send(.dismissEvent)
    }
    
    private func updateTodoItem(_ item: Todo) {
        todoUseCase.update(item)
    }
    
    private func createHistoryItem(_ item: TodoHistory) {
        historyUseCase.create(item)
    }
    
    func didTapEditButton() {
        state.send(.isEdited)
    }
}
