//
//  Process.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/13.
//

import Foundation

enum ProjectState: Int, CaseIterable {
    case todo = 0, doing, done
    
    var title: String {
        switch self {
        case .todo:
            return Title.toDo
        case .doing:
            return Title.doing
        case .done:
            return Title.done
        }
    }
    
    var index: Int {
        return rawValue
    }
    
    var movingOption: [(optionTitle: String, moveTo: ProjectState)] {
        switch self {
        case .todo:
            return  [(optionTitle: Title.moveToDoing, moveTo: .doing),
                     (optionTitle: Title.moveToDone, moveTo: .done)]
        case .doing:
            return [(optionTitle: Title.moveToToDo, moveTo: .todo),
                    (optionTitle: Title.moveToDone, moveTo: .done)]
        case .done:
            return [(optionTitle: Title.moveToToDo, moveTo: .todo),
                    (optionTitle: Title.moveToDoing, moveTo: .doing)]
        }
    }
}

extension ProjectState {
    
    private enum Title {
        
        static let toDo = "TODO"
        static let doing = "DOING"
        static let done = "DONE"
        static let moveToToDo = "Move to TODO"
        static let moveToDoing = "Move to DOING"
        static let moveToDone = "Move to DONE"
    }
}
