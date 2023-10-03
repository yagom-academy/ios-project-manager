//
//  History.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/04.
//

import Foundation

struct History: Identifiable, Equatable {
    let id: UUID
    let title: String
    let date: Date
    
    init(id: UUID = .init(), title: String, date: Date = .now) {
        self.id = id
        self.title = title
        self.date = date
    }
}
