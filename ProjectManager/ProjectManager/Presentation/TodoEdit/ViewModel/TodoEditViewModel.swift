//
//  TodoEditViewModel.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/09.
//

import Foundation
import RxSwift
import RxRelay

protocol TodoEditViewModelInput {
    func doneButtonDidTap()
    func inputitle(title: String?)
    func inputDeadline(deadline: Date)
    func inputBody(body: String?)
    func editButtonDidTap()
}

protocol TodoEditViewModelOutput {
    var setUpView: Observable<TodoModel?> { get }
    var setCreateMode: Observable<Bool> { get }
    var setEditMode: PublishRelay<Bool> { get }
}

protocol TodoEditViewModel: TodoEditViewModelInput, TodoEditViewModelOutput {}

final class DefaultTodoEditViewModel {
    private let useCase: TodoListUseCase
    private var item: TodoModel?
    private var isEditMode = false
    var setEditMode = PublishRelay<Bool>()
    
    init(useCase: TodoListUseCase, item: TodoModel?) {
        self.useCase = useCase
        self.item = item
    }
    
    private func makeEmptyTodoItem() {
        guard item == nil else { return }
        item = TodoModel()
    }
}

extension DefaultTodoEditViewModel: TodoEditViewModel {
   
    //MARK: - Output
    var setUpView: Observable<TodoModel?> {
        return Observable.just(item)
    }
    
    var setCreateMode: Observable<Bool> {
        setUpView.map { item in
            if item == nil {
                return true
            } else {
                return false
            }
        }
    }
    
    //MARK: - Input
    func doneButtonDidTap() {
        guard let item = item else {
            return
        }
        useCase.saveItem(to: item)
    }
    
    func editButtonDidTap() {
        isEditMode = !isEditMode
        setEditMode.accept(isEditMode)
    }
    
    func inputitle(title: String?) {
        if title?.isEmpty == true {
            item?.title = title
            return
        }
        makeEmptyTodoItem()
        item?.title = title
    }
    
    func inputDeadline(deadline: Date) {
        item?.deadlineAt = deadline
    }
    
    func inputBody(body: String?) {
        if body?.isEmpty == true {
            item?.body = body
            return
        }
        makeEmptyTodoItem()
        item?.body = body
    }
}
