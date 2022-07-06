//
//  TaskLocation.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 2022/07/06.
//

import RealmSwift

class TaskLocation: Object {
    @Persisted var location: String
    @Persisted var row: Int

    convenience init(location: TaskCase, row: Int) {
        self.init()
        self.location = location.rawValue
        self.row = row
    }
}
