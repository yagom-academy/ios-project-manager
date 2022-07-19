//
//  TodoEditViewModel.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/09.
//

import Foundation
import RxSwift

struct TodoEditViewModelActions {
    let dismiss: () -> Void
    let showErrorAlert: (_ message: String) -> Void
}

protocol TodoEditViewModelInput {
    func cancelButtonDidTap()
    func doneButtonDidTap()
    func inputitle(title: String?)
    func inputDeadline(deadline: Date)
    func inputBody(body: String?)
    func editButtonDidTap() -> Bool
}

protocol TodoEditViewModelOutput {
    var setUpView: Observable<TodoModel?> { get }
    var setCreateMode: Observable<Bool> { get }
}

protocol TodoEditViewModel: TodoEditViewModelInput, TodoEditViewModelOutput {}


final class DefaultTodoEditViewModel {
    private let useCase: TodoListUseCase
    private let actions: TodoEditViewModelActions?
    private var item: TodoModel?
    private var isEditMode: Bool = false
    private let bag = DisposeBag()
    
    init(useCase: TodoListUseCase, actions: TodoEditViewModelActions, item: TodoModel?) {
        self.useCase = useCase
        self.actions = actions
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
    func cancelButtonDidTap() {
        actions?.dismiss()
    }
    
    func doneButtonDidTap() {
        guard let item = item else {
            actions?.dismiss()
            return
        }
        useCase.saveItem(to: item)
            .subscribe { [weak self] in
                self?.actions?.dismiss()
            } onError: { [weak self] _ in
                self?.actions?.dismiss()
                self?.actions?.showErrorAlert("저장 오류")
            }.disposed(by: bag)
    }
    
    func editButtonDidTap() -> Bool {
        isEditMode = !isEditMode
        return isEditMode
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
