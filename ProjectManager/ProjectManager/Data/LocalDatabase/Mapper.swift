//
//  Mapper.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/03.
//

import Foundation

extension RealmTaskObject {
    func toDomain() -> Task {
        Task(
            id: self.id,
            title: self.title,
            content: self.content,
            date: self.date,
            state: TaskState(rawValue: self.state) ?? .todo
        )
    }
}

extension Task {
    func toObject() -> RealmTaskObject {
        RealmTaskObject(
            id: self.id,
            title: self.title,
            content: self.content,
            date: self.date,
            state: self.state.rawValue
        )
    }
}
