//
//  DefaultTodoDetailViewModel.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation
import Combine

protocol TodoEditViewModelInput {
    func didTapDoneButton(title: String?, content: String?, deadline: Date?)
    func didTapEditButton()
}

protocol TodoEditViewModelOutput {
    var item: Just<Todo> { get }
    var isEdited: PassthroughSubject<Void, Never> { get }
    var title: CurrentValueSubject<String, Never> { get }
    var dismissView: PassthroughSubject<Void, Never> { get }
    var showErrorAlert: PassthroughSubject<String, Never> { get }
}

protocol TodoEditViewModelable: TodoEditViewModelInput, TodoEditViewModelOutput {}

final class TodoEditViewModel: TodoEditViewModelable {
    
    // MARK: - Output
    
    var item: Just<Todo> {
        return Just(todoListModel)
    }
    
    let isEdited = PassthroughSubject<Void, Never>()
    let title = CurrentValueSubject<String, Never>("TODO")
    let dismissView = PassthroughSubject<Void, Never>()
    let showErrorAlert = PassthroughSubject<String, Never>()
    
    private let todoListModel: Todo
    private let todoUseCase: TodoListUseCaseable
    private let historyUseCase: TodoHistoryUseCaseable
    private var cancelBag = Set<AnyCancellable>()
    
    init(todoUseCase: TodoListUseCaseable, historyUseCase: TodoHistoryUseCaseable, todoListModel: Todo) {
        self.todoUseCase = todoUseCase
        self.historyUseCase = historyUseCase
        self.todoListModel = todoListModel
    }
}

extension TodoEditViewModel {
    
    // MARK: - Input
    
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
        
        todoUseCase.update(
            Todo(
                title: title,
                content: content,
                deadline: deadline,
                processType: todoListModel.processType,
                id: todoListModel.id
            )
        )
        .sink(
            receiveCompletion: {
                guard case .failure(let error) = $0 else { return}
                self.showErrorAlert.send(error.localizedDescription)
            }, receiveValue: {}
        )
        .store(in: &cancelBag)
        
        let historyItem = TodoHistory(title: "[수정] \(title)", createdAt: Date())
        
        historyUseCase.create(historyItem)
            .sink(
                receiveCompletion: {
                    guard case .failure(let error) = $0 else { return}
                    self.showErrorAlert.send(error.localizedDescription)
                }, receiveValue: {}
            )
            .store(in: &cancelBag)
        
        dismissView.send(())
    }
    
    func didTapEditButton() {
        isEdited.send(())
    }
}
