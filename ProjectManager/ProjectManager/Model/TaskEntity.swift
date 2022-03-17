//
//  Task.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/03.
//

import Foundation

class TaskEntity {
    let id: UUID
    var title: String
    var content: String
    var limitDate: Date
    var status: TaskStatus
    var statusModifiedDate: TimeInterval
    
    init(
        id: UUID = UUID(),
        title: String,
        content: String,
        limitDate: Date,
        status: TaskStatus,
        statusModifiedDate: TimeInterval
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.limitDate = limitDate
        self.status = status
        self.statusModifiedDate = statusModifiedDate
    }
    
    init(from viewModel: Task) {
        self.id = viewModel.id
        self.title = viewModel.title
        self.content = viewModel.content
        self.limitDate = viewModel.limitDate
        self.status = viewModel.status
        self.statusModifiedDate = Date().timeIntervalSince1970
    }
}

extension TaskEntity {
    func toViewModel() -> Task {
        return Task(
            id: self.id,
            title: self.title,
            content: self.content,
            limitDate: self.limitDate,
            status: self.status
        )
    }
}

extension TaskEntity: Equatable {
    static func == (lhs: TaskEntity, rhs: TaskEntity) -> Bool {
        return lhs.id == rhs.id
    }
}
