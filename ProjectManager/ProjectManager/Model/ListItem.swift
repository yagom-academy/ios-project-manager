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
    let id: String
    
    var convertedItem: ListItemDTO {
        let itemModel = ListItemDTO()
        itemModel.title = self.title
        itemModel.body = self.body
        itemModel.deadline = self.deadline
        itemModel.type = self.type.rawValue
        itemModel.id = self.id
        
        return itemModel
    }
}

enum ListType: String {
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
    
    struct Direction {
        let title: String
        let type: ListType
    }
    
    var firstDirection: Direction {
        switch self {
        case .todo:
            return Direction(title: "Move to Doing", type: .doing)
        case .doing:
            return Direction(title: "Move to Todo", type: .todo)
        case .done:
            return Direction(title: "Move to Todo", type: .todo)
        }
    }
    
    var secondDirection: Direction {
        switch self {
        case .todo:
            return Direction(title: "Move to Done", type: .done)
        case .doing:
            return Direction(title: "Move to Done", type: .done)
        case .done:
            return Direction(title: "Move to Doing", type: .doing)
        }
    }
}
