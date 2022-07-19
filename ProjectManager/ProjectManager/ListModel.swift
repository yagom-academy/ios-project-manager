//
//  ListModel.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/20.
//

import RealmSwift

final class ListModel: Object {
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
                selectListModel(.todo)?.append(item)
            }
        }
    }
    
    func updateItem(_ item: ListItem) {
        guard let realm = try? Realm() else {
            return
        }
        
        let itemModel = selectListModel(item.type)?
            .filter(NSPredicate(format: "id = %@", item.id)).first
        
        try? realm.write {
            itemModel?.title = item.title
            itemModel?.deadline = item.deadline
            itemModel?.body = item.body
        }
    }
    
    func deleteItem(_ item: ListItem) {
        guard let realm = try? Realm() else {
            return
        }
        
        guard let itemModel = selectListModel(item.type)?
            .filter(NSPredicate(format: "id = %@", item.id)).first else {
            return
        }
        
        try? realm.write {
            realm.delete(itemModel)
        }
    }
}
