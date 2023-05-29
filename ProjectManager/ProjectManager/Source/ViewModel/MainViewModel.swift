//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by songjun, vetto on 2023/05/23.
//

import Foundation
import Combine

final class MainViewModel {
    @Published var todoSchedules: [Schedule] = []
    @Published var doingSchedules: [Schedule] = []
    @Published var doneSchedules: [Schedule] = []
    
    func addTodoSchedule(_ schedule: Schedule) {
        todoSchedules.append(schedule)
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
            return todoSchedules[index]
        case .doing:
            return doingSchedules[index]
        case .done:
            return doneSchedules[index]
        }
    }
    
    func fetchScheduleList(scheduleType: ScheduleType) -> [Schedule] {
        switch scheduleType {
        case .todo:
            return todoSchedules
        case .doing:
            return doingSchedules
        case .done:
            return doneSchedules
        }
    }
    
    func deleteSchedule(scheduleType: ScheduleType, index: Int) {
        switch scheduleType {
        case .todo:
            todoSchedules.remove(at: index)
        case .doing:
            doingSchedules.remove(at: index)
        case .done:
            doneSchedules.remove(at: index)
        }
    }
    
    func fetchSchedule(scheduleType: ScheduleType) -> [Schedule] {
        switch scheduleType {
        case .todo:
            return todoSchedules
        case .doing:
            return doingSchedules
        case .done:
            return doneSchedules
        }
    }
    
    func updateSchedule(scheduleType: ScheduleType, schedule: Schedule, index: Int) {
        switch scheduleType {
        case .todo:
            todoSchedules[index] = schedule
        case .doing:
            doingSchedules[index] = schedule
        case .done:
            doneSchedules[index] = schedule
        }
    }
    
    func count(scheduleType: ScheduleType) -> Int {
        switch scheduleType {
        case .todo:
            return todoSchedules.count
        case .doing:
            return doingSchedules.count
        case .done:
            return doneSchedules.count
        }
    }
    
    func move(fromIndex: Int, from: ScheduleType, to: ScheduleType) {
        var schedule: Schedule
        var target: [Schedule]
        switch from {
        case .todo:
            schedule = todoSchedules.remove(at: fromIndex)
        case .doing:
            schedule = doingSchedules.remove(at: fromIndex)
        case .done:
            schedule = doneSchedules.remove(at: fromIndex)
        }
        
        switch to {
        case .todo:
            todoSchedules.append(schedule)
        case .doing:
            doingSchedules.append(schedule)
        case .done:
            doneSchedules.append(schedule)
        }
    }
}
