//
//  DefaultTodoDetailViewModel.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation
import Combine

protocol TodoDetailViewModelInput {
    func didTapCloseButton()
    func didTapDoneButton(title: String?, content: String?, deadLine: Date?)
    func didTapEditButton()
    func viewDidDisapper(title: String?, content: String?)
}

protocol TodoDetailViewModelOutput {
    var item: Just<TodoListModel> { get }
    var isCreate: CurrentValueSubject<Bool, Never> { get }
    var title: CurrentValueSubject<String, Never> { get }
}

protocol TodoDetailViewModelable: TodoDetailViewModelInput, TodoDetailViewModelOutput {}

final class TodoDetailViewModel: TodoDetailViewModelable {
    
    // MARK: - Output
    
    var item: Just<TodoListModel> {
        return Just(todoListModel)
    }
    
    let isCreate = CurrentValueSubject<Bool, Never>(true)
    let title = CurrentValueSubject<String, Never>("TODO")

    private weak var coordinator: TodoDetailViewCoordinator?
    private let todoListModel: TodoListModel
    private let useCase: TodoListUseCaseable
    
    init(useCase: TodoListUseCaseable, todoListModel: TodoListModel, coordinator: TodoDetailViewCoordinator?) {
        self.useCase = useCase
        self.todoListModel = todoListModel
        self.coordinator = coordinator
        
        if todoListModel.title.isEmpty && todoListModel.content.isEmpty {
            isCreate.send(true)
        } else {
            isCreate.send(false)
        }
    }
}

extension TodoDetailViewModel {
    
    // MARK: - Input
    
    func didTapCloseButton() {
        coordinator?.dismiss()
    }
    
    func didTapDoneButton(title: String?, content: String?, deadLine: Date?) {
        guard let title = title,
              let content = content,
              let deadLine = deadLine
        else {
            return
        }
        
        if title.isEmpty && content.isEmpty {
            return
        }
        
        useCase.update(
            TodoListModel(
                title: title,
                content: content,
                deadLine: deadLine,
                processType: todoListModel.processType,
                id: todoListModel.id
            )
        )
        
        coordinator?.dismiss()
    }
    
    func didTapEditButton() {
        isCreate.send(true)
    }
    
    func viewDidDisapper(title: String?, content: String?) {
        useCase.deleteLastItem(title: title, content: content)
        coordinator?.dismiss()
    }
}
