//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/06.
//

import RxSwift
import RxRelay
import RxCocoa

final class MainViewModel {
    var storage = MockStorage()

//MARK: - output
    let todoList: Driver<[ListItem]>
    let doingList: Driver<[ListItem]>
    let doneList: Driver<[ListItem]>
    
    init() {
        todoList = storage.list
            .map{ $0.filter { $0.type == .todo }}
            .asDriver(onErrorJustReturn: [])
        
        doingList = storage.list
            .map{ $0.filter { $0.type == .doing }}
            .asDriver(onErrorJustReturn: [])
        
        doneList = storage.list
            .map{ $0.filter { $0.type == .done }}
            .asDriver(onErrorJustReturn: [])
    }
    
    func isOverDeadline(listItem: ListItem) -> Bool {
        return listItem.type != .done && listItem.deadline < Date()
    }
    
    }
}
