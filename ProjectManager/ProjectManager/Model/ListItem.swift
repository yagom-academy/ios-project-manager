//
//  ListItem.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/06.
//

import Foundation

struct ListItem {
    var title: String
    var body: String
    var deadline: Date
    var type: ListType = .todo
    let id = UUID().uuidString
}

enum ListType {
    case todo
    case doing
    case done
    
    var title: String {
        switch self {
        case .todo:
            return "TODO"
        case .doing:
            return "DOING"
        case .done:
            return "DONE"
        }
    }
    
    var firstAlertTitle: String {
        switch self {
        case .todo:
            return "Move to Doing"
        case .doing:
            return "Move to Todo"
        case .done:
            return "Move to Todo"
        }
    }
    
    var secondAlertTitle: String {
        switch self {
        case .todo:
            return "Move to Done"
        case .doing:
            return "Move to Done"
        case .done:
            return "Move to Doing"
        }
    }
}
