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
    
    func fetchSchedule(index: Int, scheduleType: ScheduleType) -> Schedule {
        switch scheduleType {
        case .todo:
            return todoSchedules.value[index]
        case .doing:
            return doingSchedules.value[index]
        case .done:
            return doneSchedules.value[index]
        }
    }
    
    func roadSchedules(scheduleType: ScheduleType) -> [Schedule] {
        switch scheduleType {
        case .todo:
            return todoSchedules.value
        case .doing:
            return doingSchedules.value
        case .done:
            return doneSchedules.value
        }
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
    
    func move(fromIndex: Int, from: ScheduleType, to: ScheduleType) {
        var schedule: Schedule
        var target: Observable<[Schedule]>
        switch from {
        case .todo:
            schedule = todoSchedules.value.remove(at: fromIndex)
        case .doing:
            schedule = doingSchedules.value.remove(at: fromIndex)
        case .done:
            schedule = doneSchedules.value.remove(at: fromIndex)
        }
        
        switch to {
        case .todo:
            target = todoSchedules
        case .doing:
            target = doingSchedules
        case .done:
            target = doneSchedules
        }
        
        target.value.append(schedule)
    }
}
