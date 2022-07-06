//
//  List.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/06.
//

import Foundation

struct List {
    var title: String
    var body: String
    var deadline: Date
    var type: MenuType = .todo
    let id = UUID().uuidString
}

enum MenuType {
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
}
