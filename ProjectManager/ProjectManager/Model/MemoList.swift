//
//  MemoList.swift
//  ProjectManager
//
//  Created by Mary & Dasan on 2023/09/22.
//

struct MemoList {
    var memos: [Memo]
    var category: Category
    
    enum Category: CustomStringConvertible {
        case toDo
        case doing
        case done
        
        var description: String {
            switch self {
            case .toDo:
                return "TODO"
            case .doing:
                return "DOING"
            case .done:
                return "DONE"
            }
        }
    }
}
