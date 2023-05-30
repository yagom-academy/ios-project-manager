//
//  ProjectManager - Project.swift
//  Created by Rhode.
//  Copyright © yagom. All rights reserved.
//

import Foundation

struct Project {
    let id: UUID
    var title: String
    var body: String
    var date: Date
    var status: Status
    
    init(id: UUID = UUID(), title: String, body: String, date: Date = Date(), status: Status) {
        self.id = id
        self.title = title
        self.body = body
        self.date = date
        self.status = status
    }
}
