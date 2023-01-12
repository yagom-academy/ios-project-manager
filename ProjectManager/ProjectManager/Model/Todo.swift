//
//  Todo.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/12.
//

import Foundation

struct Todo: Hashable {
    var title: String
    var content: String?
    var deadLine: Date?
    
    var convertDeadline: String {
        guard let deadLine = deadLine else { return "" }
        return DateFormatter.convertDate(date: deadLine)
    }
}
