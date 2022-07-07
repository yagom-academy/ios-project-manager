//
//  TodoListViewModel.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/07.
//

import Foundation
import RxSwift

protocol TodoListViewModelInput {
    var listItems: BehaviorSubject<[TodoMedel]> { get }
}

protocol TodoListViewModelOutput {
    
}

protocol TodoListViewModel: TodoListViewModelInput, TodoListViewModelOutput {}

final class DefaultTodoListViewModel: TodoListViewModel {
    let listItems = BehaviorSubject<[TodoMedel]>(value: TodoMedel.makeDummy())
    
    
}
