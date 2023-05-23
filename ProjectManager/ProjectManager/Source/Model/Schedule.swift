//
//  Schedule.swift
//  ProjectManager
//
//  Created by songjun, vetto on 2023/05/17.
//

import Foundation

struct Schedule: Hashable {
    let id = UUID()
    let title: String
    let content: String
    let expirationDate: Date
    
    init(title: String = "", content: String = "", expirationDate: Date = Date()) {
        self.title = title
        self.content = content
        self.expirationDate = expirationDate
    }
}
