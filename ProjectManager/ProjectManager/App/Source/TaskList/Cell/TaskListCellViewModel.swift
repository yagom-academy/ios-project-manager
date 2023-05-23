//
//  TaskListCellViewModel.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/23.
//

import UIKit
import Combine

final class TaskListCellViewModel {
    @Published var title: String = ""
    @Published var body: String = ""
    @Published var deadlineText: String = ""
    @Published var deadlineColor: UIColor = .label
    
    func updateContents(by task: Task) {
        title = task.title
        body = task.body
        deadlineText = DateFormatter.deadlineText(date: task.deadline)
        deadlineColor = decideColor()
    }
    
    private func decideColor() -> UIColor {
        guard let date = DateFormatter.deadlineDate(text: deadlineText) else {
            return .label
        }
        
        let currentDate = DateFormatter.currentDate()
        let compareResult = currentDate?.compare(date)
        
        switch compareResult {
        case .orderedDescending:
            return .systemRed
        default:
            return .label
        }
    }
}
