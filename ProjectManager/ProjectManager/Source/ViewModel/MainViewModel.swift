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
    
    func deleteSchedule(indexPath: IndexPath) {
        todoSchedules.value.remove(at: indexPath.row)
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
}
