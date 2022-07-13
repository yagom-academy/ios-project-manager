//
//  Project.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 2022/07/05.
//

import RealmSwift

class Task: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var title: String?
    @Persisted var date: Date
    @Persisted var body: String?
    @Persisted var location: TaskLocation?

    convenience init(title: String?, date: Date, body: String?, taskLocation: TaskLocation? = nil) {
        self.init()
        self.id = id
        self.title = title
        self.date = date
        self.body = body
        self.location = taskLocation
    }
}
