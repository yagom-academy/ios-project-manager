//
//  HistoryEntity.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/26.
//

import Foundation

enum EditedType {
    case register
    case move
    case delete
    case edit
    
    var iconName: String {
        switch self {
        case .register:
            return "plus.square"
        case .move:
            return "plus.square"
        case .delete:
            return "trash.square"
        case .edit:
            return "square.and.pencil"
        }
    }
}

struct HistoryEntity {
    let editedType: String
    let title: String
    let date: String
}
