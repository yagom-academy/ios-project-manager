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
    @Persisted var date: Date
    
    convenience init(title: String) {
        self.init()
        
        self.id = UUID()
        self.title = title
        self.date = Date()
    }
}
