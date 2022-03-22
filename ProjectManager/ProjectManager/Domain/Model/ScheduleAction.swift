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
        case create(Schedule)
        case delete(Schedule)
        case update(Schedule)
        case changeProgress(Schedule, Progress?)

        var description: String {
            switch self {
            case .create(let schedule):
                return "Created \(schedule.title)"
            case .delete(let schedule):
                return "Removed \(schedule.title)"
            case .update(let schedule):
                return "Modified \(schedule.title)"
            case .changeProgress(let schedule, let progress):
                guard let progress = progress else {
                    return "Moved \(schedule.title)"
                }

                return "Moved '\(schedule.title)' from \(schedule.progress) to \(progress)."
            }
        }
    }
}
