//
//  Histroy.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/29.
//

import Foundation

struct History: Hashable, DataTransferObject {
    let id: UUID
    let title: String
    let date: TimeInterval
    
    init(title: String) {
        self.id = UUID()
        self.title = title
        self.date = Date().timeIntervalSince1970
    }
    
    init(_ realmHistory: RealmHistory) {
        self.id = realmHistory.id
        self.title = realmHistory.title        
        self.date = realmHistory.date
    }
}
