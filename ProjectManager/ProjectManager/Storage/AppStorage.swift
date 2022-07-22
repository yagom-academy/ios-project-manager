//
//  AppStorage.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/20.
//

import RxRelay

protocol AppStoregeable {
    var todoList: BehaviorRelay<[ListItem]> { get }
    var doingList: BehaviorRelay<[ListItem]> { get }
    var doneList: BehaviorRelay<[ListItem]> { get }
    func creatItem(listItem: ListItem)
    func updateItem(listItem: ListItem)
    func selectItem(index: Int, type: ListType) -> ListItem
    func deleteItem(index: Int, type: ListType)
    func changeItemType(index: Int, type: ListType, destination: ListType)
}

final class AppStorage: AppStoregeable {
    private let localStorage: LocalStorageable
    
    let todoList: BehaviorRelay<[ListItem]>
    let doingList: BehaviorRelay<[ListItem]>
    let doneList: BehaviorRelay<[ListItem]>
    
    init(_ localStorage: LocalStorageable) {
        self.localStorage = localStorage
        self.todoList = BehaviorRelay<[ListItem]>(value: localStorage.readList(.todo))
        self.doingList = BehaviorRelay<[ListItem]>(value: localStorage.readList(.doing))
        self.doneList = BehaviorRelay<[ListItem]>(value: localStorage.readList(.done))
    }
    private func selectList(_ type: ListType) -> BehaviorRelay<[ListItem]> {
        switch type {
        case .todo:
            return todoList
        case .doing:
            return doingList
        case .done:
            return doneList
        }
    }
    
    func creatItem(listItem: ListItem) {
        localStorage.createItem(listItem) { [weak self] result in
            switch result {
            case .success(let list):
                self?.selectList(listItem.type).accept(list)
            case .failure(_):
                print("에러")
            }
        }
    }
    
    func selectItem(index: Int, type: ListType) -> ListItem {
        return selectList(type).value[index]
    }
    
    func updateItem(listItem: ListItem) {
        localStorage.updateItem(listItem) { [weak self] result in
            switch result {
            case .success(let list):
                self?.selectList(listItem.type).accept(list)
            case .failure(_):
                print("에러")
            }
        }
    }
    
    func deleteItem(index: Int, type: ListType) {
        let item = selectItem(index: index, type: type)
        localStorage.deleteItem(item) { [weak self] result in
            switch result {
            case .success(let list):
                self?.selectList(item.type).accept(list)
            case .failure(_):
                print("에러")
            }
        }
    }
    
    func changeItemType(index: Int, type: ListType, destination: ListType) {
        var item = selectItem(index: index, type: type)
        deleteItem(index: index, type: type)
        
        item.type = destination
        creatItem(listItem: item)
    }
}
