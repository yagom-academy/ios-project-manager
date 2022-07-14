//
//  DefaultTodoDetailViewModel.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation
import Combine

protocol TodoDetailViewModelInput {
    func viewDidLoad()
    func didTapCloseButton()
    func didTapDoneButton(title: String?, content: String?, deadline: Date?)
    func didTapEditButton()
    func viewDidDisapper(title: String?, content: String?)
}

protocol TodoDetailViewModelOutput {
    var item: Just<TodoListModel> { get }
    var isEdited: PassthroughSubject<Bool, Never> { get }
    var isCreated: PassthroughSubject<Bool, Never> { get }
    var title: CurrentValueSubject<String, Never> { get }
}

protocol TodoDetailViewModelable: TodoDetailViewModelInput, TodoDetailViewModelOutput {}

final class TodoDetailViewModel: TodoDetailViewModelable {
    
    // MARK: - Output
    
    var item: Just<TodoListModel> {
        return Just(todoListModel)
    }
    
    let isEdited = PassthroughSubject<Bool, Never>()
    let isCreated = PassthroughSubject<Bool, Never>()
    let title = CurrentValueSubject<String, Never>("TODO")

    private weak var coordinator: TodoDetailViewCoordinator?
    private let todoListModel: TodoListModel
    private let useCase: TodoListUseCaseable
    
    init(useCase: TodoListUseCaseable, todoListModel: TodoListModel, coordinator: TodoDetailViewCoordinator? = nil) {
        self.useCase = useCase
        self.todoListModel = todoListModel
        self.coordinator = coordinator
    }
}

extension TodoDetailViewModel {
    
    // MARK: - Input
    
    func viewDidLoad() {
        if todoListModel.title.isEmpty && todoListModel.content.isEmpty {
            isCreated.send(true)
        } else {
            isEdited.send(false)
        }
    }
    
    func didTapCloseButton() {
        coordinator?.dismiss()
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
        
        useCase.update(
            TodoListModel(
                title: title,
                content: content,
                deadline: deadline,
                processType: todoListModel.processType,
                id: todoListModel.id
            )
        )
        
        coordinator?.dismiss()
    }
    
    func didTapEditButton() {
        isCreated.send(true)
    }
    
    func viewDidDisapper(title: String?, content: String?) {
        useCase.deleteLastItem(title: title, content: content)
        coordinator?.dismiss()
    }
}
