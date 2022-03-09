//
//  ScheduleUseCase.swift
//  ProjectManager
//
//  Created by Jae-hoon Sim on 2022/03/04.
//

import Foundation
import RxSwift
import RxRelay

final class ScheduleUseCase {
    private let bag = DisposeBag()
    private let scheduleProvider: Repository
    let schedules = BehaviorRelay<[Schedule]>(value: [])
    let currentSchedule = BehaviorRelay<Schedule>(value:
                                                    Schedule(title: "", body: "", dueDate: Date(), progress: .done))

    init(repository: Repository) {
        self.scheduleProvider = repository
    }

    func fetch() {
        scheduleProvider.fetch()
            .subscribe(onNext: { event in
                self.schedules.accept(event)
            })
            .disposed(by: bag)
    }

    func create(_ schedule: Schedule) -> Observable<Schedule> {

        return scheduleProvider.create(schedule)
    }

    func delete(_ scheduleID: UUID) {
        scheduleProvider.delete(scheduleID)
            .subscribe(onNext: { _ in
                let schedules = self.schedules.value.filter { schedule in
                    schedule.id != scheduleID
                }
                self.schedules.accept(schedules)
            })
            .disposed(by: bag)
    }

    func update(_ schedule: Schedule) -> Observable<Schedule> {

        return scheduleProvider.update(schedule)
    }

    func changeProgress(schedule: Schedule, progress: Progress) -> Observable<Schedule> {

        return scheduleProvider.update(convertedProgress(schedule: schedule, progress: progress))
    }

    func setCurrentSchedule(schedule: Schedule) {
        self.currentSchedule.accept(schedule)
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
