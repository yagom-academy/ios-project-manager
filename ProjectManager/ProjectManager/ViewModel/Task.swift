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
    
    init(
        id: UUID = UUID(),
        title: String,
        content: String,
        limitDate: Date
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.limitDate = limitDate
    }
}
