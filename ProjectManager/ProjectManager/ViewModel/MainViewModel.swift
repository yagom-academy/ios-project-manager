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
    func deleteList(index: Int, type: ListType)
    func changeListType(index: Int, type: ListType, to: ListType)
}

final class MainViewModel: MainViewModelInOut {
    private var storage: Storegeable

//MARK: - output
    let todoList: Driver<[ListItem]>
    let doingList: Driver<[ListItem]>
    let doneList: Driver<[ListItem]>
    
    init(storage: Storegeable) {
        self.storage = storage
        
        todoList = storage.list
            .map{ $0.filter { $0.type == .todo }}
            .map{ $0.sorted(by: { $0.deadline < $1.deadline}) }
            .asDriver(onErrorJustReturn: [])
        
        doingList = storage.list
            .map{ $0.filter { $0.type == .doing }}
            .map{ $0.sorted(by: { $0.deadline < $1.deadline}) }
            .asDriver(onErrorJustReturn: [])
        
        doneList = storage.list
            .map{ $0.filter { $0.type == .done }}
            .map{ $0.sorted(by: { $0.deadline < $1.deadline}) }
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
            todoList.drive(onNext: {
                completion($0[index])
            })
            .dispose()
        case .doing:
            doingList.drive(onNext: {
                completion($0[index])
            })
            .dispose()
        case .done:
            doneList.drive(onNext: {
                completion($0[index])
            })
            .dispose()
        }
    }
    
    func deleteList(index: Int, type: ListType) {
        peekList(index: index, type: type) {
            self.storage.deleteList(listItem: $0)
        }
    }
    
    func changeListType(index: Int, type: ListType, to: ListType) {
        peekList(index: index, type: type) {
            var listItem = $0
            listItem.type = to
            self.storage.updateList(listItem: listItem)
        }
    }
}
