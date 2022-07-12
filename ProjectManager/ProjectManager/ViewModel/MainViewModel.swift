//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/06.
//

import RxSwift
import RxRelay
import RxCocoa

protocol MainViewModelInOut: MainViewModelInput, MainViewModelOutput {}

protocol MainViewModelOutput {
    var todoList: Driver<[ListItem]> { get }
    var doingList: Driver<[ListItem]> { get }
    var doneList: Driver<[ListItem]> { get }
}

protocol MainViewModelInput {
    func isOverDeadline(listItem: ListItem) -> Bool
    func peekList(index: Int, type: ListType, completion: @escaping ((ListItem) -> Void))
    func creatList(listItem: ListItem)
    func updateList(listItem: ListItem)
    func deleteList(index: Int, type: ListType)
    func changeListType(listItem: ListItem, type: ListType)
}

final class MainViewModel: MainViewModelInOut {

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
}

//MARK: - input
extension MainViewModel {
    func isOverDeadline(listItem: ListItem) -> Bool {
        return listItem.type != .done && listItem.deadline < Date()
    }
    
    func peekList(index: Int, type: ListType, completion: @escaping ((ListItem) -> Void)) {
        switch type {
        case .todo:
            _ = todoList.drive(onNext: {
                completion($0[index])
            })
            .dispose()
        case .doing:
            _ = doingList.drive(onNext: {
                completion($0[index])
            })
            .dispose()
        case .done:
            _ = doneList.drive(onNext: {
                completion($0[index])
            })
            .dispose()
        }
    }
    
    func creatList(listItem: ListItem) {
        storage.creatList(listItem: listItem)
    }
    
    func updateList(listItem: ListItem) {
        storage.updateList(listItem: listItem)
    }
    
    func deleteList(index: Int, type: ListType) {
        switch type {
        case .todo:
            _ = todoList.drive(onNext: {
                self.storage.deleteList(listItem: $0[index])
            })
            .dispose()
        case .doing:
            _ = doingList.drive(onNext: {
                self.storage.deleteList(listItem: $0[index])
            })
            .dispose()
        case .done:
            _ = doneList.drive(onNext: {
                self.storage.deleteList(listItem: $0[index])
            })
            .dispose()
        }

    }
    
    func changeListType(listItem: ListItem, type: ListType) {
        
    }
}
