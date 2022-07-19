//
//  ProjectContent.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/06.
//

import Foundation

enum ProjectStatus {
    case todo
    case doing
    case done
    
    var string: String {
        switch self {
        case .todo:
            return "TODO"
        case .doing:
            return "DOING"
        case .done:
            return "DONE"
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .todo:
            return "Move to TODO"
        case .doing:
            return "Move to DOING"
        case .done:
            return "Move to DONE"
        }
    }
    
    static func convert(titleText: String?) -> ProjectStatus? {
        switch titleText {
        case ProjectStatus.todo.buttonTitle:
            return .todo
        case ProjectStatus.doing.buttonTitle:
            return .doing
        case ProjectStatus.done.buttonTitle:
            return .done
        default:
            return nil
        }
    }
    
    static func convert(statusString: String?) -> ProjectStatus? {
        switch statusString {
        case ProjectStatus.todo.string:
            return .todo
        case ProjectStatus.doing.string:
            return .doing
        case ProjectStatus.done.string:
            return .done
        default:
            return nil
        }
    }
}

struct ProjectContent {
    let id: UUID
    var status: ProjectStatus
    var title: String
    var deadline: String
    var body: String
    
    init(id: UUID = UUID(), status: ProjectStatus = .todo, title: String, deadline: Date, body: String) {
        self.id = id
        self.status = status
        self.title = title
        self.deadline = DateFormatter().formatted(date: deadline)
        self.body = body
    }
    
    mutating func editContent(title: String? = nil,
                              deadline: Date? = nil,
                              body: String? = nil
    ) {
        if let title = title {
            self.title = title
        }
        
        if let deadline = deadline {
            self.deadline = DateFormatter().formatted(date: deadline)
        }
        
        if let body = body {
            self.body = body
        }
    }
}

extension ProjectContent {
    static func == (lhs: ProjectContent, rhs: ProjectContent) -> Bool {
        return lhs.id == rhs.id
    }
}
