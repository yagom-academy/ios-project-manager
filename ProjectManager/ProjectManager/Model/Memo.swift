//
//  Memo.swift
//  ProjectManager
//
//  Created by kjs on 2021/11/02.
//

import SwiftUI

struct Memo: Identifiable, Equatable {
    var id: UUID
    var title: String
    var body: String
    var date: Date
    var state: State

    var isEmpty: Bool {
        return title.isEmpty && body.isEmpty
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }

    enum State: Int, CaseIterable, CustomStringConvertible {
        case todo = 0
        case done = 1
        case doing = 2
        
        var description: String {
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
}
