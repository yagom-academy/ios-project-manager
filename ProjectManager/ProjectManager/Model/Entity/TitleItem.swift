//
//  TitleItem.swift
//  ProjectManager
//
//  Created by Hemg on 2023/10/01.
//

enum TitleItem {
    case todo
    case doing
    case done
    
    var title: String {
        switch self {
        case .todo:
            return "Move to TODO"
        case .doing:
            return  "Move to DOING"
        case .done:
            return  "Move to DONE"
        }
    }
}
