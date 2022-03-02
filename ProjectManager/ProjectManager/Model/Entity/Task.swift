//
//  Task.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/01.
//

import Foundation

struct Task: Identifiable {
    
    let id: UUID
    var title: String
    var description: String
    var dueDate: Date
    var status: TaskStatus
    
}

extension Task: Equatable { }
