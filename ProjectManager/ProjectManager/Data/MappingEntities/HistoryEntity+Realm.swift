//
//  HistoryEntity+Realm.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/25.
//

import Foundation
import RealmSwift

final class HistoryRealmEntity: Object {
    @Persisted private var changes: String
    @Persisted private var title: String
    @Persisted private var beforeState: String?
    @Persisted private var afterState: String?
    @Persisted private var createAt: Date
    
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
