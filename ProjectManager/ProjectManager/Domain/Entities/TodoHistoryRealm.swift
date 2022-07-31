//
//  TodoHistoryRealm.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/19.
//

import Foundation

import RealmSwift

final class TodoHistoryRealm: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var title: String
    @Persisted var createdAt: Date
    
    convenience init(id: String, title: String, createdAt: Date) {
        self.init()
        self.id = id
        self.title = title
        self.createdAt = createdAt
    }
}
