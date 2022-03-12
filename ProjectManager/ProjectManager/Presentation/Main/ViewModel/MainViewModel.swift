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
import UIKit

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
        let tableViewLongPressed: [Observable<(UITableViewCell, Schedule)?>]
        let cellDidTap: [Observable<Schedule>]
        let cellDelete: [Observable<UUID>]
        let addButtonDidTap: Observable<Void>
    }

    struct Output {
        let scheduleLists: [Observable<[Schedule]>]
    }

    // MARK: - Methods

    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        input.viewWillAppear
            .subscribe(onNext: {
                self.useCase.fetch()
            })
            .disposed(by: disposeBag)

        input.cellDidTap.forEach { observable in
            observable
                .do(onNext: { _ in self.coordinator.presentScheduleItemViewController(mode: .detail) })
                .bind(to: self.useCase.currentSchedule)
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
            observable.subscribe(onNext: { observable in
                guard let (cell, schedule) = observable else {
                    return
                }
                self.useCase.currentSchedule.accept(schedule)
                self.coordinator.presentPopoverViewController(at: cell)
            })
                .disposed(by: bag)
        }

        return bindOutput()
    }
}

private extension MainViewModel {
    func bindOutput() -> Output {
        let output = Output(
            scheduleLists: Progress.allCases
                .map { progress in
                    self.useCase.schedules
                        .map { schedules in
                            return schedules.filter { schedule in schedule.progress == progress }
                        }
                }
        )
        return output
    }
}
