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
            return "arrow.left.arrow.right.square"
        case .delete:
            return "trash"
        case .edit:
            return "square.and.pencil"
        }
    }
}

struct HistoryEntity {
    let editedType: String
    let title: String
    let date: String
    
    init(editedType: EditedType, title: String, date: TimeInterval) {
        self.editedType = editedType.iconName
        self.title = title
        self.date = String(date)
    }
}
