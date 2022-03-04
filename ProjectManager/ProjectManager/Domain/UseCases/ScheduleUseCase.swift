//
//  ScheduleUseCase.swift
//  ProjectManager
//
//  Created by Jae-hoon Sim on 2022/03/04.
//

import Foundation
import RxSwift


class ScheduleUseCase {
    let scheduleProvider: Repository
    
    init(repository: Repository) {
        self.scheduleProvider = repository
    }
    
    func fetch() -> Observable<[Schedule]> {
        
        return scheduleProvider.fetch()
    }
    
    func create(_ schedule: Schedule) -> Observable<Schedule> {
        
        return scheduleProvider.create(schedule)
    }
    
    func delete(_ scheduleID: UUID) -> Observable<Bool> {
        
        return scheduleProvider.delete(scheduleID)
    }
    
    func update(_ schedule: Schedule) -> Observable<Schedule> {
        
        return scheduleProvider.update(schedule)
    }
    
    func changeProgress(schedule: Schedule, progress: Progress) -> Observable<Schedule> {
        
        return scheduleProvider.update(convertedProgress(schedule: schedule, progress: progress))
    }
}

private extension ScheduleUseCase {
    
    func convertedProgress(schedule: Schedule, progress: Progress) -> Schedule {
        return Schedule(
            title: schedule.title,
            body: schedule.body,
            dueDate: schedule.dueDate,
            progress: progress
        )
    }
}
