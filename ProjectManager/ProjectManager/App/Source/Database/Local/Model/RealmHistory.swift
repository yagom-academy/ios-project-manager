//
//  RealmHistory.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/30.
//

import Foundation
import RealmSwift

final class RealmHistory: Object {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var title: String
    @Persisted var date: TimeInterval
    
    convenience init(_ history: History) {
        self.init()
        
        self.id = history.id
        self.title = history.title
        self.date = history.date
    }
}
