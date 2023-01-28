//
//  ToDo.swift
//  ProjectManager
//
//  Created by som on 2023/01/11.
//

import Foundation

struct Plan: Hashable, Equatable, Identifiable, Sendable {
    enum Status {
        case todo
        case doing
        case done

        var name: String {
            switch self {
            case .todo:
                return Content.toDo
            case .doing:
                return Content.doing
            case .done:
                return Content.done
            }
        }
    }

    var status: Status
    var title: String
    var description: String
    var deadline: Date
    let id: UUID
    var validContent: Bool {
        return ((title != PlanText.title && title != PlanText.emptyString) || (description != PlanText.description && description != PlanText.emptyString))
    }
}

extension UUID: @unchecked Sendable { }
extension Date: @unchecked Sendable { }
