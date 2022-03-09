//
//  Task.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/08.
//

import Foundation

class Task: Identifiable, ObservableObject {
    let id: UUID
    @Published var title: String
    @Published var content: String
    @Published var limitDate: Date
    @Published var status: TaskStatus
    
    init(
        id: UUID = UUID(),
        title: String,
        content: String,
        limitDate: Date,
        status: TaskStatus
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.limitDate = limitDate
        self.status = status
    }
}
