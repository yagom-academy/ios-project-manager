//
//  ScheduleAction.swift
//  ProjectManager
//
//  Created by Lee Seung-Jae on 2022/03/22.
//

import Foundation

final class ScheduleAction {
    var isUndone: Bool
    let execute: () -> Void
    let reverse: () -> Void
    let type: ActionType
    let time: Date

    init(type: ActionType, execute: @escaping () -> Void, reverse: @escaping () -> Void) {
        self.type = type
        self.isUndone = false
        self.time = Date()
        self.execute = execute
        self.reverse = reverse
    }
}

extension ScheduleAction {
    enum ActionType: CustomStringConvertible {
        case add(Schedule)
        case delete(Schedule)
        case modify(Schedule)
        case move(Schedule, Progress?)

        var description: String {
            switch self {
            case .add(let schedule):
                return "Created \(schedule.title)"
            case .delete(let schedule):
                return "Removed \(schedule.title)"
            case .modify(let schedule):
                return "Modified \(schedule.title)"
            case .move(let schedule, let progress):
                guard let progress = progress else {
                    return "Moved \(schedule.title)"
                }

                return "Moved '\(schedule.title)' from \(schedule.progress) to \(progress)."
            }
        }
    }
}
