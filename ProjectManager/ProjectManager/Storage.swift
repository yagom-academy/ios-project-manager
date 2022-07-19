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
    lazy var todoList = BehaviorRelay<[ListItem]>(value: readList(.todo))
    lazy var doingList = BehaviorRelay<[ListItem]>(value: readList(.doing))
    lazy var doneList = BehaviorRelay<[ListItem]>(value: readList(.done))
    
    private func selectListModel(_ type: ListType) -> List<ListItemModel>? {
        guard let realm = try? Realm() else {
            return nil
        }
        
        guard let listModel = realm.objects(ListModel.self).first else {
            return nil
        }
        
        switch type {
        case .todo:
            return listModel.todoList
        case .doing:
            return listModel.doingList
        case .done:
            return listModel.doneList
        }
    }
    
    private func readList(_ type: ListType) -> [ListItem] {
        guard let listModel = selectListModel(type) else {
            return []
        }
        
        let list: [ListItem] = listModel
            .compactMap { $0.changedItem }
            .sorted { $0.deadline < $1.deadline }
        return list
    }
    
    func creatList(listItem: ListItem) {
        
    }
    
    func selectItem(index: Int, type: ListType) -> ListItem {
        switch type {
        case .todo:
            return todoList.value[index]
        case .doing:
            return doingList.value[index]
        case .done:
            return doneList.value[index]
        }
    }
    
    func updateList(listItem: ListItem) {
        
    }
    
    func deleteList(index: Int, type: ListType) {
        
    }
    
    func changeListType(index: Int, type: ListType, destination: ListType) {
        
    }
}
