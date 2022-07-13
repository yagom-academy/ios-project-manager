//
//  Project.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 2022/07/05.
//

import RealmSwift

class Project: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var title: String?
    @Persisted var date: Date
    @Persisted var body: String?
    
    init(title: String?, date: Date, body: String?) {
        super.init()
        self.id = UUID().uuidString
        self.title = title
        self.date = date
        self.body = body
    }
}
