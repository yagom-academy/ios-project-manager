//
//  Histroy.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/29.
//

import Foundation

struct History: Hashable {
    let id: UUID
    let title: String
    let date: Date
    
    init(title: String) {
        self.id = UUID()
        self.title = title
        self.date = Date()
    }
    
    init(_ realmHistory: RealmHistory) {
        self.id = realmHistory.id
        self.title = realmHistory.title        
        self.date = realmHistory.date
    }
}
