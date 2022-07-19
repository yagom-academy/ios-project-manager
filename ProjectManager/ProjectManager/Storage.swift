//
//  Storage.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/20.
//
import RxRelay

final class Storage: Storegeable {
    var todoList = BehaviorRelay<[ListItem]>(value: [])
    
    var doingList = BehaviorRelay<[ListItem]>(value: [])
    
    var doneList = BehaviorRelay<[ListItem]>(value: [])
    
    func creatList(listItem: ListItem) {
        
    }
    
    func updateList(listItem: ListItem) {
        
    }
    
    func selectItem(index: Int, type: ListType) -> ListItem {
    return ListItem(title: "", body: "", deadline: Date(), id: "")
    }
    
    func deleteList(index: Int, type: ListType) {
        
    }
    
    func changeListType(index: Int, type: ListType, destination: ListType) {
        
    }
}
