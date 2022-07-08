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
}

protocol TodoEditViewModelInput {
    var listItems: BehaviorSubject<[TodoModel]> { get }
    var actions: TodoEditViewModelActions? { get }
}

protocol TodoEditViewModel: TodoEditViewModelInput {}

final class DefaultTodoEditViewModel: TodoEditViewModel {
    private let useCase: UseCase
    
    var listItems: BehaviorSubject<[TodoModel]>
    
    var actions: TodoEditViewModelActions?
    
    init(useCase: UseCase, actions: TodoEditViewModelActions) {
        self.useCase = useCase
        self.actions = actions
        
        listItems = useCase.readRepository()
    }
}
