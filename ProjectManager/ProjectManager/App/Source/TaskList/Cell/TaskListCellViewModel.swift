//
//  TaskListCellViewModel.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/23.
//

import UIKit
import Combine

final class TaskListCellViewModel {
    func decideDeadlineColor(state: TaskState, date: Date) -> UIColor {
        guard state != .done else {
            return .label
        }
        
        let formattedDateText = DateFormatter.deadlineText(date: date)
        
        guard let formattedDate = DateFormatter.deadlineDate(text: formattedDateText) else {
            return .label
        }
        
        let currentDate = DateFormatter.currentDate()
        let compareResult = currentDate?.compare(formattedDate)
        
        switch compareResult {
        case .orderedDescending:
            return .systemRed
        default:
            return .label
        }
    }
}
