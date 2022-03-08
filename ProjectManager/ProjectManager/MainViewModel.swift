//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by Jae-hoon Sim on 2022/03/08.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

final class MainViewModel {

// MARK: - Properties

    var schedules = [Driver<[Schedule]>]()

    private let bag = DisposeBag()
    private let useCase: ScheduleUseCase
    private let scheduleList = BehaviorRelay<[Schedule]>(value: [])

// MARK: - Initializer

    init(useCase: ScheduleUseCase) {
        self.useCase = useCase

        self.bindOutput()
    }

// MARK: - Methods

    func fetch() {
        self.useCase.fetch()
            .subscribe { event in
                self.scheduleList.accept(event)
            }
            .disposed(by: self.bag)
    }

    func delete(id: UUID) {
        self.useCase.delete(id)
            .filter { $0 }
            .subscribe(onNext: { _ in
                let schedules = self.scheduleList.value.filter { schedule in
                    schedule.id != id
                }
                self.scheduleList.accept(schedules)
            })
            .disposed(by: self.bag)
    }
}

// MARK: - Private Methods

private extension MainViewModel {

    func bindOutput() {
        Progress.allCases.forEach { progress in
            self.schedules.append(
                self.scheduleList
                    .map { $0.filter { schedule in schedule.progress == progress } }
                    .asDriver(onErrorJustReturn: [])
            )
        }
    }
}

extension Schedule {

    var formattedDateString: String {
        return DateFormatter.dueDate.string(from: self.dueDate)
    }
}
