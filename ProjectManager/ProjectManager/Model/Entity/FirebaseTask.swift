//
//  FirebaseTask.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/21.
//

import Foundation

struct FirebaseTask: Codable {
    
    let id: UUID
    let title: String
    let description: String
    let dueDate: Date
    let status: Int
    
}
