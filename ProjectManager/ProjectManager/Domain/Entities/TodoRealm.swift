//
//  TodoRealm.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/18.
//

import Foundation

import RealmSwift

final class TodoRealm: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var title: String
    @Persisted var content: String
    @Persisted var deadline: Date
    @Persisted var processType: ProcessType
    
    convenience init(title: String, content: String, deadline: Date, processType: ProcessType, id: String) {
        self.init()
        self.title = title
        self.content = content
        self.deadline = deadline
        self.processType = processType
        self.id = id
    }
}
