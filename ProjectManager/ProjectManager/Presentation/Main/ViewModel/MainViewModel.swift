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
    var coordinator: MainViewCoordinator

    private let bag = DisposeBag()
    let useCase: ScheduleUseCase
    private let indexPath = BehaviorRelay<IndexPath>(value: IndexPath(item: 0, section: 0))
    // MARK: - Initializer

    init(coordinator: MainViewCoordinator, useCase: ScheduleUseCase) {
        self.coordinator = coordinator
        self.useCase = useCase
    }

    struct Input {
        let viewWillAppear: Observable<Void>
        let tableViewLongPressed: [Observable<Schedule?>]
        let cellDidTap: [Observable<Schedule>]
        let cellDelete: [Observable<UUID>]
        let addButtonDidTap: Observable<Void>
    }

    struct Output {
        let scheduleLists = [
            BehaviorRelay<[Schedule]>(value: []),
            BehaviorRelay<[Schedule]>(value: []),
            BehaviorRelay<[Schedule]>(value: [])
        ]
    }

    // MARK: - Methods

    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        bindOutput(output: output, disposeBag: disposeBag)

        input.viewWillAppear
            .subscribe(onNext: {
                self.useCase.fetch()
            })
            .disposed(by: disposeBag)

        input.cellDidTap.forEach { observable in
            observable
                .subscribe(onNext: { schedule in
                    self.useCase.setCurrentSchedule(schedule: schedule)
                    self.coordinator.presentScheduleItemViewController(mode: .detail)
                })
                .disposed(by: disposeBag)
        }

        input.cellDelete.forEach { observable in
            observable.subscribe(onNext: { id in
                self.useCase.delete(id)
            })
                .disposed(by: disposeBag)
        }

        input.addButtonDidTap
            .subscribe(onNext: {
                self.coordinator.presentScheduleItemViewController(mode: .create)
            })
            .disposed(by: bag)

        input.tableViewLongPressed.forEach { observable in
            observable.subscribe(onNext: { schedule in
                if schedule == nil {
                    return
                }
                self.useCase.currentSchedule.accept(schedule)
            })
                .disposed(by: bag)
        }

        return output
    }
}

private extension MainViewModel {
    func bindOutput(output: Output, disposeBag: DisposeBag) {
        self.useCase.schedules
            .subscribe(onNext: { schedules in
                Progress.allCases.enumerated().forEach { index, progress in
                    let filtered = schedules.filter { schedule in schedule.progress == progress }
                    output.scheduleLists[index].accept(filtered)
                }
            })
            .disposed(by: disposeBag)
    }
}

extension Schedule {

    var formattedDateString: String {
        return DateFormatter.dueDate.string(from: self.dueDate)
    }
}
