//
//  Memo.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/10/28.
//

import Foundation

enum MemoState: String, CaseIterable, Codable {
    case toDo = "TODO"
    case doing = "DOING"
    case done = "DONE"
    
    var description: String {
        return self.rawValue
    }
    
    var indexValue: Int {
        switch self {
        case .toDo:
            return 0
        case .doing:
            return 1
        case .done:
            return 2
        }
    }
}

struct Memo: Identifiable, Codable {
    var id = UUID()
    var title = ""
    var description = ""
    var date = Date()
    var status = MemoState.toDo
}


