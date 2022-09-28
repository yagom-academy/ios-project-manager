//
//  Todo.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/14.
//

import Foundation
import RealmSwift

class Todo: Object {
    @objc dynamic var id: UUID = UUID()
    @objc dynamic var category: String = Category.todo
    @objc dynamic var title: String = ""
    @objc dynamic var body: String = ""
    @objc dynamic var date: Date = Date()
    
    convenience init(id: UUID, category: String, title: String, body: String, date: Date) {
        self.init()
        self.id = id
        self.category = category
        self.title = title
        self.body = body
        self.date = date
    }
}
