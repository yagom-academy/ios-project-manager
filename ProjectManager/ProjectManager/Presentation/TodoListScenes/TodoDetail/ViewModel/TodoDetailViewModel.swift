//
//  DefaultTodoDetailViewModel.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation
import Combine

protocol TodoDetailViewModelInput {
    func closeButtonDidTap()
    func doneButtonDidTap(title: String, content: String, deadLine: Date)
    func editButtonDidTap()
    func viewDidDisapper()
}

protocol TodoDetailViewModelOutput {
    var item: Just<TodoListModel> { get }
    var isCreate: CurrentValueSubject<Bool, Never> { get }
}

protocol TodoDetailViewModelable: TodoDetailViewModelInput, TodoDetailViewModelOutput {}

final class TodoDetailViewModel: TodoDetailViewModelable {
    
    // MARK: - Output
    
    var item: Just<TodoListModel> {
        return Just(todoListModel)
    }
    
    let isCreate = CurrentValueSubject<Bool, Never>(true)

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
    
    func closeButtonDidTap() {
        if todoListModel.title.isEmpty && todoListModel.content.isEmpty {
            useCase.deleteLastItem()
        }
        
        viewDidDisapper()
    }
    
    func doneButtonDidTap(title: String, content: String, deadLine: Date) {
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
        
        viewDidDisapper()
    }
    
    func editButtonDidTap() {
        isCreate.send(true)
    }
    
    func viewDidDisapper() {
        coordinator?.dismiss()
    }
}
