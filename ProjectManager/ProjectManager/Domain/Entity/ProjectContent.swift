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
    
    static func convert(_ titleText: String?) -> ProjectStatus? {
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
}

struct ProjectContent {
    let id: UUID
    var status: ProjectStatus = .todo
    var title: String
    var deadline: String
    var description: String
    
    init(id: UUID = UUID(), title: String, deadline: Date, description: String) {
        self.id = id
        self.title = title
        self.deadline = DateFormatter().formatted(date: deadline)
        self.description = description
    }
    
    mutating func editContent(title: String? = nil,
                              deadline: Date? = nil,
                              description: String? = nil
    ) {
        if let title = title {
            self.title = title
        }
        
        if let deadline = deadline {
            self.deadline = DateFormatter().formatted(date: deadline)
        }
        
        if let description = description {
            self.description = description
        }
    }
    
    func getStatus() -> ProjectStatus? {
        return MockStorageManager.shared.read(id: id)?.status
    }
    
    mutating func updateStatus(_ status: ProjectStatus) {
        self.status = status
        MockStorageManager.shared.update(projectContent: self)
    }
}

extension ProjectContent {
    static func == (lhs: ProjectContent, rhs: ProjectContent) -> Bool {
        return lhs.id == rhs.id
    }
}
