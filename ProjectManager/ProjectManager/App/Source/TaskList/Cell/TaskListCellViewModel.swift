//
//  TaskListCellViewModel.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/23.
//

import UIKit
import Combine

final class TaskListCellViewModel {
    func decideDeadlineColor(state: TaskState, date: TimeInterval) -> UIColor {
        guard state != .done else {
            return .label
        }
        
        let currentDate = Date().timeIntervalSince1970
        let secondsPerAllDay = 60 * 60 * 24
        let currentWithoutSecond = Int(currentDate) / secondsPerAllDay
        let targetWithoutSecond = Int(date) / secondsPerAllDay
        
        if currentWithoutSecond > targetWithoutSecond {
            return .systemRed
        } else {
            return .label
        }
    }
}
