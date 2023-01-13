//
//  ProjectProcess.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/13.
//

import Foundation

enum ProjectProcess {
    case todo, doing, done
    
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
