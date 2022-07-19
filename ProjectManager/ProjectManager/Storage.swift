//
//  Storage.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/20.
//

import RxRelay
import RealmSwift

class ListModel: Object {
    private let todoList = List<ListItemModel>()
    private let doingList = List<ListItemModel>()
    private let doneList = List<ListItemModel>()
    
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
    
    func readList(_ type: ListType) -> [ListItem] {
        guard let listModel = ListModel().selectListModel(type) else {
            return []
        }
        
        let list: [ListItem] = listModel
            .compactMap { $0.changedItem }
            .sorted { $0.deadline < $1.deadline }
        return list
    }
    
    func createItem(_ item: ListItemModel) {
        guard let realm = try? Realm() else {
            return
        }
        
        if realm.objects(ListModel.self).isEmpty {
            let listModel = ListModel()
            listModel.todoList.append(item)
            
            try? realm.write {
                realm.add(listModel)
            }
        } else {
            try? realm.write {
                let listModel = realm.objects(ListModel.self)
                listModel.first?.todoList.append(item)
            }
        }
    }
    
    func updateItem(_ item: ListItem) {
        guard let realm = try? Realm() else {
            return
        }
        let itemModel = selectListModel(item.type)?.filter(NSPredicate(format: "id = %@", item.id)).first
        try? realm.write {
            itemModel?.title = item.title
            itemModel?.deadline = item.deadline
            itemModel?.body = item.body
            itemModel?.type = item.type.rawValue
        }
        
    }
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
