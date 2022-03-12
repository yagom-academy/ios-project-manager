//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by Jae-hoon Sim on 2022/03/08.
//

import RxSwift
import RxRelay
import RxCocoa
import UIKit

final class MainViewModel {

    // MARK: - Properties

    let useCase: ScheduleUseCase
    private let coordinator: MainViewCoordinator
    private let bag = DisposeBag()

    // MARK: - Initializer

    init(coordinator: MainViewCoordinator, useCase: ScheduleUseCase) {
        self.coordinator = coordinator
        self.useCase = useCase
    }

    // MARK: - Input/Output

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
        onViewWillAppear(input.viewWillAppear)
            .disposed(by: disposeBag)

        onAddButtonDidTap(input.addButtonDidTap)
            .disposed(by: disposeBag)

        input.cellDidTap.map(self.onCellDidTap(_:))
            .forEach { $0.disposed(by: disposeBag) }

        input.cellDelete.map(self.onCellDelete(_:))
            .forEach { $0.disposed(by: disposeBag) }

        input.tableViewLongPressed.map(self.onLongPressed(_:))
            .forEach { $0.disposed(by: disposeBag) }

        return bindOutput()
    }
}

private extension MainViewModel {

    func onViewWillAppear(_ input: Observable<Void>) -> Disposable {
        return input
            .subscribe(onNext: self.useCase.fetch)
    }

    func onAddButtonDidTap(_ input: Observable<Void>) -> Disposable {
        return input
            .subscribe(onNext: {
                self.coordinator.presentScheduleItemViewController(mode: .create)
            })
    }

    func onCellDidTap(_ input: Observable<Schedule>) -> Disposable {
        return input
            .do(onNext: { _ in self.coordinator.presentScheduleItemViewController(mode: .detail) })
            .bind(to: self.useCase.currentSchedule)
    }

    func onCellDelete(_ input: Observable<UUID>) -> Disposable {
        return input
            .subscribe(onNext: self.useCase.delete(_:))
    }

    func onLongPressed(_ input: Observable<(UITableViewCell, Schedule)?>) -> Disposable {
        return input
            .flatMap(Observable.from(optional:))
            .do(onNext: { self.coordinator.presentPopoverViewController(at: $0.0) })
            .map { $0.1 }
            .bind(to: self.useCase.currentSchedule)
    }

    func bindOutput() -> Output {
        let scheduleLists = Progress.allCases
            .map { progress in self.useCase.schedules
                .map { $0.filter { $0.progress == progress } }
            }

        return Output(scheduleLists: scheduleLists)
    }
}
