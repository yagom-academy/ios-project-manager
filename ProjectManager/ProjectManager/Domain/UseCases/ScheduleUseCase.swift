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

    // MARK: - Properties

    let schedules = BehaviorRelay<[Schedule]>(value: [])
    let currentSchedule = BehaviorRelay<Schedule?>(value: nil)
    private let bag = DisposeBag()
    private let scheduleProvider: Repository

    // MARK: - Initializer

    init(repository: Repository) {
        self.scheduleProvider = repository
    }

    // MARK: - Methods

    func fetch() {
        self.scheduleProvider.fetch()
            .subscribe(onNext: { event in
                self.schedules.accept(event)
            })
            .disposed(by: self.bag)
    }

    func create(_ schedule: Schedule) {
        self.scheduleProvider.create(schedule)
            .subscribe(onNext: { schedule in
                var schedules = self.schedules.value
                schedules.append(schedule)

                self.schedules.accept(schedules)
            })
            .disposed(by: self.bag)
    }

    func delete(_ scheduleID: UUID) {
        self.scheduleProvider.delete(scheduleID)
            .subscribe(onNext: { _ in
                let schedules = self.schedules.value.filter { schedule in
                    schedule.id != scheduleID
                }
                self.schedules.accept(schedules)
            })
            .disposed(by: self.bag)
    }

    func update(_ schedule: Schedule) {
        self.scheduleProvider.update(schedule)
            .subscribe(onNext: { newSchedule in
                var schedules = self.schedules.value
                guard let index = schedules.enumerated()
                        .filter({ $0.element.id == newSchedule.id })
                        .map({ $0.0 }).first
                else { return }

                schedules[safe: index] = newSchedule

                self.schedules.accept(schedules)
            })
            .disposed(by: self.bag)
    }

    func changeProgress(of schedule: Schedule, progress: Progress?) {
        guard let progress = progress else { return }
        self.update(convert(schedule: schedule, for: progress))
    }
}

// MARK: - Private Methods
private extension ScheduleUseCase {

    func convert(schedule: Schedule, for progress: Progress) -> Schedule {
        return Schedule(
            id: schedule.id,
            title: schedule.title,
            body: schedule.body,
            dueDate: schedule.dueDate,
            progress: progress
        )
    }
}
