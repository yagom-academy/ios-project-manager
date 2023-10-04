//
//  RealmHistoryObject.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/04.
//

import Foundation
import RealmSwift

final class RealmHistoryObject: Object {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var title: String
    @Persisted var date: Date
    
    convenience init(
        id: UUID,
        title: String,
        date: Date
    ) {
        self.init()
        self.id = id
        self.title = title
        self.date = date
    }
}

