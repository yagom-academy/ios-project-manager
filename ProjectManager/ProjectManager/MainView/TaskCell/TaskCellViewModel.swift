//
//  TaskCellViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/17.
//

import Foundation
import Combine

final class TaskCellViewModel {
    @Published var title: String
    @Published var body: String
    @Published var date: String
    @Published var isDateExpired: Bool?
    
    init(task: Task, dateFormatter: DateFormatter) {
        title = task.title
        body = task.body
        date = dateFormatter.string(from: task.date)
        if task.workState != .done {
            isDateExpired = validateDate(with: dateFormatter)
        }
    }
    
    private func validateDate(with dateFormatter: DateFormatter) -> Bool? {
        let todayString = dateFormatter.string(from: Date())
        guard let today = dateFormatter.date(from: todayString),
              let taskDate = dateFormatter.date(from: self.date) else {
            return nil
        }
        
        let result = today.compare(taskDate)
        
        return (result == .orderedDescending) ? true : false
    }
}
