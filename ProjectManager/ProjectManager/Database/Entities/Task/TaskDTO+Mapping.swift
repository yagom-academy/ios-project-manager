//
//  TaskDTO+Mapping.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/06.
//

import Foundation

extension TaskDTO {
    func toDomain() -> Task {
        Task(id: UUID(uuidString: self.id) ?? .init(),
             title: self.title,
             content: self.content,
             date: self.date,
             state: TaskState(rawValue: self.state) ?? .todo
        )
    }
}

extension Task {
    func toDTO() -> TaskDTO {
        TaskDTO(
            id: self.id.uuidString,
            title: self.title,
            content: self.content,
            date: self.date,
            state: self.state.rawValue
        )
    }
}
