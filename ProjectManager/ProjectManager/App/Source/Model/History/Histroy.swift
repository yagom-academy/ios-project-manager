//
//  Histroy.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/29.
//

import Foundation

struct History {
    let title: String
    let date: Date
    
    init(title: String) {
        self.title = title
        self.date = Date()
    }
}
