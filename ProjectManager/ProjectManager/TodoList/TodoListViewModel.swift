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
 
    private var dataBase: DataBase
        
    init(dataBase: DataBase) {
        self.dataBase = dataBase
        
        self.todoViewData = dataBase.data
            .map { $0.filter { $0.status == .todo } }
            .asDriver(onErrorJustReturn: [])
        
        self.doingViewData = dataBase.data
            .map { $0.filter { $0.status == .doing } }
            .asDriver(onErrorJustReturn: [])
        
        self.doneViewData = dataBase.data
            .map { $0.filter { $0.status == .done } }
            .asDriver(onErrorJustReturn: [])
    }
}
