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
    func setList(_ completion: @escaping (Result<(), StorageError>) -> Void)
    func creatItem(listItem: ListItem) throws
    func updateItem(listItem: ListItem) throws
    func selectItem(index: Int, type: ListType) -> ListItem
    func deleteItem(listItem: ListItem) throws
    func changeItemType(listItem: ListItem, destination: ListType) throws
}

final class AppStorage: AppStoregeable {
    private let localStorage: LocalStorageManagerable
    
    let todoList: BehaviorRelay<[ListItem]>
    let doingList: BehaviorRelay<[ListItem]>
    let doneList: BehaviorRelay<[ListItem]>
    
    init(_ localStorage: LocalStorageManagerable) {
        self.localStorage = localStorage
        self.todoList = BehaviorRelay<[ListItem]>(value: localStorage.readList(.todo))
        self.doingList = BehaviorRelay<[ListItem]>(value: localStorage.readList(.doing))
        self.doneList = BehaviorRelay<[ListItem]>(value: localStorage.readList(.done))
    }
    
    func setList(_ completion: @escaping (Result<Void, StorageError>) -> Void) {
        localStorage.setList { result in
            switch result {
            case .success():
                self.todoList.accept(self.localStorage.readList(.todo))
                self.doingList.accept(self.localStorage.readList(.doing))
                self.doneList.accept(self.localStorage.readList(.done))
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
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
        do {
            try localStorage.createItem(listItem)
            let newList = localStorage.readList(listItem.type)
            selectList(listItem.type).accept(newList)
            
        } catch {
            throw StorageError.creatError
        }
    }
    
    func selectItem(index: Int, type: ListType) -> ListItem {
        return selectList(type).value[index]
    }

    func updateItem(listItem: ListItem) throws {
        do {
            try localStorage.updateItem(listItem)
            let nweList = localStorage.readList(listItem.type)
            selectList(listItem.type).accept(nweList)
        } catch {
            throw StorageError.updateError
        }
    }
    
    func deleteItem(listItem: ListItem) throws {
        do {
            try localStorage.deleteItem(listItem)
            let nweList = localStorage.readList(listItem.type)
            selectList(listItem.type).accept(nweList)
            
        } catch {
            throw StorageError.deleteError
        }
    }

    func changeItemType(listItem: ListItem, destination: ListType) throws {
        var item = listItem
        do {
            try deleteItem(listItem: item)
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
