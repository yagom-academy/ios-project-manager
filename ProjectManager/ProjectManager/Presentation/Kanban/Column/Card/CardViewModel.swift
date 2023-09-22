//
//  CardViewModel.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/22.
//

import Foundation

final class CardViewModel {
    let task: Task
    
    init(task: Task) {
        self.task = task
    }
    
    var date: String {
        return task.date.formatted(date: .numeric, time: .omitted)
    }

    var isOverdued: Bool {
        let calendar = Calendar.current
        let now = Date()
        
        return calendar.compare(task.date, to: now, toGranularity: .day) == .orderedAscending
    }
}
