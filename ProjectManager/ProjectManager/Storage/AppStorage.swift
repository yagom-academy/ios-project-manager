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
    func creatItem(listItem: ListItem) throws
    func updateItem(listItem: ListItem) throws
    func selectItem(index: Int, type: ListType) -> ListItem
    func deleteItem(index: Int, type: ListType) throws
    func changeItemType(index: Int, type: ListType, destination: ListType) throws
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
    
    func creatItem(listItem: ListItem) throws {
        var createError: StorageError?
        
        localStorage.createItem(listItem) { [weak self] result in
            switch result {
            case .success(let list):
                self?.selectList(listItem.type).accept(list)
            case .failure(let error):
                createError = error
            }
        }
        
        if createError != nil {
            throw StorageError.creatError
        }
    }
    
    func selectItem(index: Int, type: ListType) -> ListItem {
        return selectList(type).value[index]
    }
    
    func updateItem(listItem: ListItem) throws {
        var updateError: StorageError?
        
        localStorage.updateItem(listItem) { [weak self] result in
            switch result {
            case .success(let list):
                self?.selectList(listItem.type).accept(list)
            case .failure(let error):
                updateError = error
            }
        }
        
        if updateError != nil {
            throw StorageError.updateError
        }
    }
    
    func deleteItem(index: Int, type: ListType) throws {
        let item = selectItem(index: index, type: type)
        var deleteError: StorageError?
        
        localStorage.deleteItem(item) { [weak self] result in
            switch result {
            case .success(let list):
                self?.selectList(item.type).accept(list)
            case .failure(let error):
                deleteError = error
            }
        }
        
        if deleteError != nil {
            throw StorageError.deleteError
        }
    }
    
    func changeItemType(index: Int, type: ListType, destination: ListType) throws {
        var item = selectItem(index: index, type: type)
        
        do {
            try deleteItem(index: index, type: type)
        } catch {
            throw StorageError.updateError
        }
        
        
        item.type = destination
        do {
            try creatItem(listItem: item)
        } catch {
            throw StorageError.updateError
        }
    }
}
