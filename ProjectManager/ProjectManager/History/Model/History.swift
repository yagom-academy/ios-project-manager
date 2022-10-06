//
//  SendModel.swift
//  ProjectManager
//
//  Created by seohyeon park on 2022/09/28.
//

import Foundation

struct History {
    var activity: Activity
    var title: String
    var from: String
    var to: String?
    var date: Date
}

enum Activity {
    case moved
    case added
    case removed

    var name: String {
        switch self {
        case .moved:
            return "Moved"
        case .added:
            return "Added"
        case .removed:
            return "Removed"
        }
    }
}
