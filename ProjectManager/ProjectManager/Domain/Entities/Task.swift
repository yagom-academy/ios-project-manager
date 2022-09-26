//
//  Task.swift
//  ProjectManager
//
//  Created by 이예은 on 2022/09/22.
//

import Foundation

struct Task {
    let id: UUID
    let title: String
    let body: String
    let date: Date
    var state: TaskState
    
    init(entity: TaskModelDTO) {
        id = entity["id"] as! UUID
        title = entity["title"] as! String
        body = entity["body"] as! String
        date = entity["date"] as! Date
        state = entity["state"] as! TaskState
    }
    
    init(viewModel: TaskViewModel) {
        id = viewModel.id
        title = viewModel.title
        body = viewModel.body
        date = viewModel.date.toDate()
        state = viewModel.state
    }
    
    init(id: UUID, title: String, body: String, date: Date, state: TaskState) {
        self.id = id
        self.title = title
        self.body = body
        self.date = date
        self.state = state
    }
}
