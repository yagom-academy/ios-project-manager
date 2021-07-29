//
//  Task.swift
//  ProjectManager
//
//  Created by steven on 7/22/21.
//

import Foundation
import MobileCoreServices

final class Task: NSObject, Codable {
    var title: String
    var content: String
    var deadLine: String
    var type: TaskType
    
    init(title: String, content: String, deadLine: String, type: TaskType) {
        self.title = title
        self.content = content
        self.deadLine = deadLine
        self.type = type
    }
}
