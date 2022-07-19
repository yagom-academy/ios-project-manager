//
//  Storage.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/20.
//

import RxRelay
import RealmSwift

final class Storage: Storegeable {
    private let listModel = ListModel()
    
    lazy var todoList = BehaviorRelay<[ListItem]>(value: listModel.readList(.todo))
    lazy var doingList = BehaviorRelay<[ListItem]>(value: listModel.readList(.doing))
    lazy var doneList = BehaviorRelay<[ListItem]>(value: listModel.readList(.done))
    
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
        listModel.createItem(listItem.changedItem)
        todoList.accept(listModel.readList(.todo))
    }
    
    func selectItem(index: Int, type: ListType) -> ListItem {
        return selectList(type).value[index]
    }
    
    func updateItem(listItem: ListItem) {
        listModel.updateItem(listItem)
        
        let newList = listModel.readList(listItem.type)
        selectList(listItem.type).accept(newList)
    }
    
    func deleteItem(index: Int, type: ListType) {
        
    }
    
    func changeItemType(index: Int, type: ListType, destination: ListType) {
        
    }
}
