//
//  TodoListViewModel.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/05.
//

import Foundation

import RxCocoa
import RxRelay
import RxSwift

final class TodoListViewModel {
    let todoViewData: Driver<[Todo]>
    let doingViewData: Driver<[Todo]>
    let doneViewData: Driver<[Todo]>
    
    private var dataBase: Database
    
    init(dataBase: Database) {
        self.dataBase = dataBase
        
        self.todoViewData = dataBase.todoListBehaviorRelay
            .map { $0.filter { $0.todoListItemStatus == .todo } }
            .map { $0.sorted{ $0.date < $1.date } }
            .asDriver(onErrorJustReturn: [])
        
        self.doingViewData = dataBase.todoListBehaviorRelay
            .map { $0.filter { $0.todoListItemStatus == .doing } }
            .map { $0.sorted{ $0.date < $1.date } }
            .asDriver(onErrorJustReturn: [])
        
        self.doneViewData = dataBase.todoListBehaviorRelay
            .map { $0.filter { $0.todoListItemStatus == .done } }
            .map { $0.sorted{ $0.date < $1.date } }
            .asDriver(onErrorJustReturn: [])
    }
    
    func cellSelectEvent(indexPathRow: Int, todoListItemStatus: TodoListItemStatus?, completion: @escaping (Todo) -> Void ) {
        guard let todoListItemStatus = todoListItemStatus else {
            return
        }
        
        switch todoListItemStatus {
        case .todo:
            self.todoViewData.drive(onNext: {
                    completion($0[indexPathRow])
                })
                .dispose()
        case .doing:
            self.doingViewData.drive(onNext: {
                    completion($0[indexPathRow])
                })
                .dispose()
        case .done:
            self.doneViewData.drive(onNext: {
                    completion($0[indexPathRow])
                })
                .dispose()
        }
    }
    
    func cellDeleteEvent(selectedTodo: Todo) {
        self.dataBase.delete(todoID: selectedTodo.identifier)
    }
}
