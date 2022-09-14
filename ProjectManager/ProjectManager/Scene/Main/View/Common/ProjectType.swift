//
//  ProjectType.swift
//  ProjectManager
//
//  Created by 김동용 on 2022/09/13.
//

import UIKit

enum ProjectType: CaseIterable {
    case todo
    case doing
    case done
    
    var titleLabel: String {
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
