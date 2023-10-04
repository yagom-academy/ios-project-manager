//
//  Memo.swift
//  ProjectManager
//
//  Created by Mary & Dasan on 2023/09/22.
//

import Foundation

struct Memo: Identifiable {
    var id = UUID()
    var title: String
    var body: String
    var deadline: Date
    var category: Category
    
    static let newMemo = Memo(title: "", body: "", deadline: .now, category: .toDo)
    
    enum Category: CustomStringConvertible, CaseIterable {
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
