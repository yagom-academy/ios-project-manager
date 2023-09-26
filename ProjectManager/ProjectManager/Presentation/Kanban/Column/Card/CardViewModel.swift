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
        
        return calendar.compare(task.date, to: now, toGranularity: .day) == .orderedAscending && task.state != .done
    }
    
    var firstDestination: TaskState {
        return destination(of: .first)
    }
    
    var secondDestination: TaskState {
        return destination(of: .second)
    }
    
    private func destination(of destinationOrder: DestinationOrder) -> TaskState {
        var states: [TaskState] = [.todo, .doing , .done]
        guard let index = states.firstIndex(of: task.state) else { return .done }
        states.remove(at: index)
        return states[destinationOrder.rawValue]
    }
    
    enum DestinationOrder: Int {
        case first = 0, second
    }    
}
