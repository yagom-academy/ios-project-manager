//
//  FirebaseTask.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/21.
//

import Foundation

struct FirebaseTask: Codable {
    
    let id: String
    let title: String
    let description: String
    let dueDate: Double
    let status: Int
    
}


extension FirebaseTask {
    
    init(_ object: Task) {
        self.id = object.id.uuidString
        self.title = object.title
        self.description = object.description
        self.dueDate = object.dueDate.timeIntervalSince1970
        self.status = object.status.rawValue
    }
    
}
