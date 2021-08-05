//
//  DummyJsonData.swift
//  ProjectManagerTests
//
//  Created by 이영우 on 2021/08/04.
//

import Foundation

enum DummyJsonData {
    case tasks
    case requestTask
    case responseTask
}

extension DummyJsonData: CustomStringConvertible {
    var description: String {
        switch self {
        case .tasks:
            return """
            [
                 {
                     "title" : "책상정리",
                     "description" : "집중이 안될땐 역시나 책상정리",
                     "dueDate" : 1624933807.141012,
                     "status" : "todo",
                     "id" : "1731F34B-C6B5-40DD-B07E-6CBDC444382C"
                 },
                 {
                     "title" : "일기쓰기",
                    "description" : "집중이 안될땐 역시나 일기쓰기",
                    "dueDate" : 162493123132.141012,
                    "status" : "doing",
                    "id" : "1731F34B-C6B5-40DD-NJ95-6CBDC444382C"
                 }
            ]
            """
        case .requestTask:
            return """
            {
                "title" : "책상정리",
                "description" : "집중이 안될땐 역시나 책상정리",
                "dueDate" : 1624933807.141012,
                "status" : "todo",
            }
            """
        case .responseTask:
            return """
            {
                "title" : "책상정리",
                "description" : "집중이 안될땐 역시나 책상정리",
                "dueDate" : 1624933807.141012,
                "status" : "todo",
                "id" : "1731F34B-C6B5-40DD-B07E-6CBDC444382C"
            }
            """
        }
    }
    
    var data: Data? {
        self.description.data(using: .utf8)
    }
}
