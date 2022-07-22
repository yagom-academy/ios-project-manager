//
//  ListItemDTO.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/20.
//

import RealmSwift

final class ListItemDTO: Object {
    @Persisted var title: String = ""
    @Persisted var body: String = ""
    @Persisted var deadline: Date = Date()
    @Persisted var type: String = ""
    @Persisted(primaryKey: true) var id: String = ""
    
    var convertedItem: ListItem {
        return ListItem(title: self.title,
                        body: self.body,
                        deadline: self.deadline,
                        type: ListType(rawValue: self.type) ?? .todo,
                        id: self.id)
    }
}
