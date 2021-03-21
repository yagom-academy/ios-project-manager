//
//  Todo.swift
//  ProjectManager
//
//  Created by sole on 2021/03/09.
//

import Foundation
import MobileCoreServices

final class Todo: Codable {
    var title: String
    var descriptions: String?
    var deadLine: Date?
    
    init(title: String, descriptions: String?, deadLine: Date?) {
        self.title = title
        self.descriptions = descriptions
        self.deadLine = deadLine
    }
}
