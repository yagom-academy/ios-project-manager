//
//  HistoryEntity+Realm.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/25.
//

import Foundation
import RealmSwift

class HistoryRealmEntity: Object {
    @Persisted var changes: String
    @Persisted var title: String
    @Persisted var beforeState: String?
    @Persisted var afterState: String?
    @Persisted var createAt: Date
    
    convenience init(entity: History) {
        self.init()
        self.changes = entity.changes.rawValue
        self.title = entity.title
        self.beforeState = entity.beforeState?.rawValue
        self.afterState = entity.afterState?.rawValue
        self.createAt = entity.createAt
    }
    
    func toHistory() -> History {
        return History(changes: Changes(rawValue: changes) ?? .added,
                       title: title,
                       beforeState: State(rawValue: beforeState ?? ""),
                       afterState: State(rawValue: afterState ?? ""))
    }
}
