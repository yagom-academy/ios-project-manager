//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by kimseongjun on 2023/05/23.
//

import Foundation
import Combine

final class MainViewModel {
    let todoSchedules: Observable<[Schedule]> = Observable([])
    let doingSchedules: Observable<[Schedule]> = Observable([])
    let doneSchedules: Observable<[Schedule]> = Observable([])
    
    func addTodoSchedule(_ schedule: Schedule) {
        todoSchedules.value.append(schedule)
    }
    
    func createSchedule(titleText: String?, contentText: String?, expirationDate: Date) -> Schedule {
        guard let validTitleText = titleText, let validContentText = contentText else {
            return Schedule()
        }
        
        let schedule = Schedule(title: validTitleText, content: validContentText, expirationDate: expirationDate)
        
        return schedule
    }
    
    func schedule() -> [Schedule] {
        return self.todoSchedules.value
    }
    
    func deleteSchedule(scheduleType: ScheduleType, index: Int) {
        switch scheduleType {
        case .todo:
            todoSchedules.value.remove(at: index)
        case .doing:
            doingSchedules.value.remove(at: index)
        case .done:
            doneSchedules.value.remove(at: index)
        }
    }
    
    func fetchSchedule(scheduleType: ScheduleType) -> [Schedule] {
        switch scheduleType {
        case .todo:
            return todoSchedules.value
        case .doing:
            return doingSchedules.value
        case .done:
            return doneSchedules.value
        }
    }
    
    func updateSchedule(scheduleType: ScheduleType, schedule: Schedule, index: Int) {
        switch scheduleType {
        case .todo:
            todoSchedules.value[index] = schedule
        case .doing:
            doingSchedules.value[index] = schedule
        case .done:
            doneSchedules.value[index] = schedule
        }
    }
    
    func count(scheduleType: ScheduleType) -> Int {
        switch scheduleType {
        case .todo:
            return todoSchedules.value.count
        case .doing:
            return doingSchedules.value.count
        case .done:
            return doneSchedules.value.count
        }
    }
}
