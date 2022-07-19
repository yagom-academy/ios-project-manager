//
//  Storage.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/20.
//

import RxRelay
import RealmSwift

class ListModel: Object {
    let todoList = List<ListItemModel>()
    let doingList = List<ListItemModel>()
    let doneList = List<ListItemModel>()
}

class ListItemModel: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var body: String = ""
    @objc dynamic var deadline: Date = Date()
    @objc dynamic var type: String = ""
    @objc dynamic var id: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    var changedItem: ListItem {
        return ListItem(title: self.title,
                        body: self.body,
                        deadline: self.deadline,
                        type: ListType(rawValue: self.type) ?? .todo,
                        id: self.id)
    }
}


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
