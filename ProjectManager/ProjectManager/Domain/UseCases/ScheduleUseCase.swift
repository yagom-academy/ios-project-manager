//
//  ScheduleUseCase.swift
//  ProjectManager
//
//  Created by Jae-hoon Sim on 2022/03/04.
//

import Foundation
import RxSwift
import RxRelay

final class ScheduleUseCase: MainUseCase, ScheduleItemUseCase {

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
            .subscribe(onSuccess: { [weak self] event in
                self?.schedules.accept(event)
            })
            .disposed(by: self.bag)
    }

    func create(_ schedule: Schedule) {
        self.scheduleProvider.create(schedule)
            .subscribe(onCompleted: { [weak schedules] in
                guard var currentSchedules = schedules?.value else { return }
                currentSchedules.append(schedule)

                schedules?.accept(currentSchedules)
            })
            .disposed(by: self.bag)
    }

    func delete(_ scheduleID: UUID) {
        self.scheduleProvider.delete(scheduleID)
            .subscribe(onCompleted: { [weak schedules] in
                guard let newSchedules = schedules?.value.filter({ schedule in
                    schedule.id != scheduleID
                }) else { return }
                schedules?.accept(newSchedules)
            })
            .disposed(by: self.bag)
    }

    func update(_ schedule: Schedule) {
        self.scheduleProvider.update(schedule)
            .subscribe(onCompleted: { [weak schedules] in
                guard var currentSchedules = schedules?.value else { return }
                guard let index = currentSchedules.enumerated()
                        .filter({ $0.element.id == schedule.id })
                        .map({ $0.0 }).first
                else { return }

                currentSchedules[safe: index] = schedule

                schedules?.accept(currentSchedules)
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
