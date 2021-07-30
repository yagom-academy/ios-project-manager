//
//  RequestTask.swift
//  ProjectManager
//
//  Created by 이영우 on 2021/07/30.
//

import Foundation

struct RequestTask: Codable {
    let title: String
    let content: String
    let deadLine: TimeInterval
    let type: TaskType
    
    enum CodingKeys: String, CodingKey {
        case title
        case content = "description"
        case deadLine = "dueDate"
        case type = "status"
    }
}
