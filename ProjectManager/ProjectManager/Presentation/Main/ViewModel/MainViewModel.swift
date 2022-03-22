//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by Jae-hoon Sim on 2022/03/08.
//

import Foundation
import RxSwift
import RxRelay

private enum Name {
    static let progressText = "Move to "
}

final class MainViewModel {

    // MARK: - Properties

    let scheduleUseCase: MainUseCase
    let scheduleHistoryUseCase: ScheduleHistoryUseCase
    private let coordinator: MainViewCoordinator
    private let bag = DisposeBag()

    // MARK: - Initializer

    init(
        coordinator: MainViewCoordinator,
        sceduleUseCase: MainUseCase,
        scheduleHistoryUseCase: ScheduleHistoryUseCase
    ) {
        self.coordinator = coordinator
        self.scheduleUseCase = sceduleUseCase
        self.scheduleHistoryUseCase = scheduleHistoryUseCase
    }

    // MARK: - Input/Output

    struct Input {
        let viewWillAppear: Observable<Void>
        let tableViewLongPressed: Observable<(Schedule, IndexPath, Int)?>
        let cellDidTap: [Observable<Schedule>]
        let cellDelete: [Observable<Schedule>]
        let addButtonDidTap: Observable<Void>
        let popoverTopButtonDidTap: Observable<Void>
        let popoverBottomButtonDidTap: Observable<Void>
        let historyButtonDidTap: Observable<Void>
        let undoButtonDidTap: Observable<Void>
        let redoButtonDidTap: Observable<Void>
    }

    struct Output {
        let scheduleLists: [Observable<[Schedule]>]
        let popoverShouldPresent: Observable<(IndexPath, Int)>
        let popoverTopButtonTitle: Observable<String>
        let popoverBottomButtonTitle: Observable<String>
    }

    // MARK: - Methods

    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        self.onViewWillAppear(input.viewWillAppear)
            .disposed(by: disposeBag)

        self.onAddButtonDidTap(input.addButtonDidTap)
            .disposed(by: disposeBag)

        input.cellDidTap.map({ [weak self] in self?.onCellDidTap($0) })
            .forEach { $0?.disposed(by: disposeBag) }

        input.cellDelete.map({ [weak self] in self?.onCellDelete($0) })
            .forEach { $0?.disposed(by: disposeBag) }

        input.popoverTopButtonDidTap
            .withLatestFrom(input.tableViewLongPressed)
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] schedule, _, _ in
                let targetProgress = Progress.allCases.filter { $0 != schedule.progress }.first
                self?.scheduleUseCase.changeProgress(of: schedule, progress: targetProgress)
                let action = ScheduleAction(
                    execute: { self?.scheduleUseCase.changeProgress(of: schedule, progress: targetProgress) },
                    reverse: { self?.scheduleUseCase.changeProgress(of: schedule, progress: schedule.progress)}
                )
                self?.scheduleHistoryUseCase.recodeHistory(action: action)
            })
            .disposed(by: disposeBag)

        input.popoverBottomButtonDidTap
            .withUnretained(self)
            .withLatestFrom(input.tableViewLongPressed)
            .compactMap { $0 }
            .subscribe(onNext: { schedule, _, _ in
                let targetProgress = Progress.allCases.filter { $0 != schedule.progress }.last
                self.scheduleUseCase.changeProgress(of: schedule, progress: targetProgress)
                let action = ScheduleAction(
                    execute: { self.scheduleUseCase.changeProgress(of: schedule, progress: targetProgress) },
                    reverse: { self.scheduleUseCase.changeProgress(of: schedule, progress: schedule.progress)}
                )
                self.scheduleHistoryUseCase.recodeHistory(action: action)
            })
            .disposed(by: disposeBag)

        input.undoButtonDidTap
            .withUnretained(self)
            .subscribe(onNext: { unretained, _ in
                unretained.scheduleHistoryUseCase.undo()
            })
            .disposed(by: disposeBag)

        input.redoButtonDidTap
            .withUnretained(self)
            .subscribe(onNext: { unretained, _ in
                unretained.scheduleHistoryUseCase.redo()
            })
            .disposed(by: disposeBag)

        return bindOutput(input: input)
    }
}

private extension MainViewModel {

    func onViewWillAppear(_ input: Observable<Void>) -> Disposable {
        return input
            .subscribe(onNext: { [weak self] in self?.scheduleUseCase.fetch() })
    }

    func onAddButtonDidTap(_ input: Observable<Void>) -> Disposable {
        return input
            .subscribe(onNext: { [weak self] in
                self?.coordinator.presentScheduleItemViewController(mode: .create)
            })
    }

    func onCellDidTap(_ input: Observable<Schedule>) -> Disposable {
        return input
            .do(afterNext: { [weak self] _ in
                self?.coordinator.presentScheduleItemViewController(mode: .detail) })
            .bind(to: self.scheduleUseCase.currentSchedule)
    }

    func onCellDelete(_ input: Observable<Schedule>) -> Disposable {
        return input
            .subscribe(onNext: { [weak self] schedule in
                self?.scheduleUseCase.delete(schedule.id)
                let action = ScheduleAction(
                    execute: { self?.scheduleUseCase.delete(schedule.id) },
                    reverse: { self?.scheduleUseCase.create(schedule) }
                )
                self?.scheduleHistoryUseCase.recodeHistory(action: action)
            })
    }

    func bindOutput(input: Input) -> Output {
        let scheduleLists = Progress.allCases
            .compactMap { [weak self] progress in
                self?.scheduleUseCase.schedules
                .map { $0.filter { $0.progress == progress } }
            }

        let popoverViewEvent = input.tableViewLongPressed
            .compactMap { $0 }
            .map { ($0.1, $0.2) }

        let popoverTopButtonTitle = input.tableViewLongPressed
            .compactMap { $0?.0 }
            .map { schedule -> String in
                let targetProgress = Progress.allCases.filter { $0 != schedule.progress }
                return Name.progressText + (targetProgress.first?.description ?? .empty)
            }

        let popoverBottomButtonTitle = input.tableViewLongPressed
            .compactMap { $0?.0 }
            .map { schedule -> String in
                let targetProgress = Progress.allCases.filter { $0 != schedule.progress }
                return Name.progressText + (targetProgress.last?.description ?? .empty)
            }

        return Output(
            scheduleLists: scheduleLists,
            popoverShouldPresent: popoverViewEvent,
            popoverTopButtonTitle: popoverTopButtonTitle,
            popoverBottomButtonTitle: popoverBottomButtonTitle
        )
    }
}
