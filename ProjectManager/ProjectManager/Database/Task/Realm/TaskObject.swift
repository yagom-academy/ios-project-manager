//
//  RealmTaskObject.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/03.
//

import Foundation
import RealmSwift

final class TaskObject: Object {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var title: String
    @Persisted var content: String
    @Persisted var date: Date
    @Persisted var state: Int8
    
    convenience init(
        id: UUID,
        title: String,
        content: String,
        date: Date,
        state: Int8
    ) {
        self.init()
        self.id = id
        self.title = title
        self.content = content
        self.date = date
        self.state = state
    }
}
