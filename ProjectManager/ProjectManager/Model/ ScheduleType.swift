//
//   ScheduleType.swift
//  ProjectManager
//
//  Created by Toy on 1/24/24.
//

enum Schedule {
    case todo
    case doing
    case done
}

extension Schedule {
    var discription: String {
        switch self {
        case .todo:
            return NameSpace.todo
        case .doing:
            return NameSpace.doing
        case .done:
            return NameSpace.done
        }
    }
}
