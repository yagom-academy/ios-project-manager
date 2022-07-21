//
//  AppStorage.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/20.
//

import RxRelay

protocol Storegeable {
    var todoList: BehaviorRelay<[ListItem]> { get }
    var doingList: BehaviorRelay<[ListItem]> { get }
    var doneList: BehaviorRelay<[ListItem]> { get }
    func creatItem(listItem: ListItem)
    func updateItem(listItem: ListItem)
    func selectItem(index: Int, type: ListType) -> ListItem
    func deleteItem(index: Int, type: ListType)
    func changeItemType(index: Int, type: ListType, destination: ListType)
}

final class AppStorage: Storegeable {
    private let localStorage = LocalStorage()
    
    lazy var todoList = BehaviorRelay<[ListItem]>(value: localStorage.readList(.todo))
    lazy var doingList = BehaviorRelay<[ListItem]>(value: localStorage.readList(.doing))
    lazy var doneList = BehaviorRelay<[ListItem]>(value: localStorage.readList(.done))
    
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
        localStorage.createItem(listItem.convertedItem)
        todoList.accept(localStorage.readList(.todo))
    }
    
    func selectItem(index: Int, type: ListType) -> ListItem {
        return selectList(type).value[index]
    }
    
    func updateItem(listItem: ListItem) {
        localStorage.updateItem(listItem)
        
        let newList = localStorage.readList(listItem.type)
        selectList(listItem.type).accept(newList)
    }
    
    func deleteItem(index: Int, type: ListType) {
        let item = selectItem(index: index, type: type)
        localStorage.deleteItem(item)
        
        let newList = localStorage.readList(type)
        
        selectList(type).accept(newList)
    }
    
    func changeItemType(index: Int, type: ListType, destination: ListType) {
        var item = selectItem(index: index, type: type)
        localStorage.deleteItem(item)
        let deletedList = localStorage.readList(type)
        
        item.type = destination
        creatItem(listItem: item)
        let addedList = localStorage.readList(destination)
        
        selectList(type).accept(deletedList)
        selectList(destination).accept(addedList)
    }
}
