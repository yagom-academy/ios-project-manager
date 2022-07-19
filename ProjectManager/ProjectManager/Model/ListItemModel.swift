//
//  ListItemModel.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/20.
//

import RealmSwift

final class ListItemModel: Object {
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
