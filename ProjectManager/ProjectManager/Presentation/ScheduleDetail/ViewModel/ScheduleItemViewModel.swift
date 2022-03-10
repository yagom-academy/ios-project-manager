//
//  ScheduleDetailViewModel.swift
//  ProjectManager
//
//  Created by Lee Seung-Jae on 2022/03/09.
//

import Foundation
import RxSwift
import RxRelay
import UIKit

class ScheduleItemViewModel {

    enum Mode {
        case detail, edit, create
    }

    // MARK: - Properties
    private let bag = DisposeBag()
    private let useCase: ScheduleUseCase
    private let coordinator: ScheduleItemCoordinator

    private let mode: BehaviorRelay<Mode>
    private let currentTitleText = BehaviorRelay<String>(value: "")
    private let currentDate = BehaviorRelay<Date>(value: Date())
    private let currentBodyText = BehaviorRelay<String>(value: "")
    private let currentValidity: Observable<Bool>

    // MARK: - Initializer

    init(useCase: ScheduleUseCase, coordinator: ScheduleItemCoordinator, mode: Mode) {
        self.useCase = useCase
        self.coordinator = coordinator
        self.mode = BehaviorRelay<Mode>(value: mode)
        self.currentValidity = Observable.combineLatest(
            self.currentTitleText.map { !$0.isEmpty },
            self.currentBodyText.map { !$0.isEmpty },
            self.mode.map { $0 == .detail},
            resultSelector: { $0 && $1 || $2 })
    }

    struct Input {
        let leftBarButtonDidTap: Observable<Void>
        let rightBarButtonDidTap: Observable<Void>
        let scheduleTitleTextDidChange: Observable<String>
        let scheduleDateDidChange: Observable<Date>
        let scheduleBodyTextDidChange: Observable<String>
        let viewDidDisappear: Observable<Void>
    }

    struct Output {
        let scheduleProgress = BehaviorRelay<String>(value: "")
        let scheduleTitleText = BehaviorRelay<String>(value: "")
        let scheduleDate = BehaviorRelay<Date>(value: Date())
        let scheduleBodyText = BehaviorRelay<String>(value: "")
        let leftBarButtonText = BehaviorRelay<String>(value: "")
        let rightBarButtonText = BehaviorRelay<String>(value: "")
        let editable = BehaviorRelay<Bool>(value: false)
        let isValid = BehaviorRelay<Bool>(value: false)
    }

    // MARK: - Methods

    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        bindOutput(output: output, disposeBag: disposeBag)

        input.leftBarButtonDidTap
            .subscribe(onNext: { _ in
                switch self.mode.value {
                case .detail:
                    self.mode.accept(.edit)
                case .edit:
                    guard let schedule = self.useCase.currentSchedule.value else {
                        return
                    }
                    self.useCase.setCurrentSchedule(schedule: schedule)
                    self.mode.accept(.detail)
                case .create:
                    self.coordinator.dismiss()
                }
            })
            .disposed(by: disposeBag)

        input.rightBarButtonDidTap
            .subscribe(onNext: { _ in
                switch self.mode.value {
                case .detail:
                    self.coordinator.dismiss()
                case .edit:
                    guard let schedule = self.useCase.currentSchedule.value else { return }
                    let newSchedule = Schedule(
                        id: schedule.id!,
                        title: self.currentTitleText.value,
                        body: self.currentBodyText.value,
                        dueDate: self.currentDate.value,
                        progress: schedule.progress)

                    self.useCase.update(newSchedule)
                    self.coordinator.dismiss()
                case .create:
                    let newSchedule = Schedule(
                        title: self.currentTitleText.value,
                        body: self.currentBodyText.value,
                        dueDate: self.currentDate.value,
                        progress: .todo)

                    self.useCase.create(newSchedule)
                    self.coordinator.dismiss()
                }
            })
            .disposed(by: disposeBag)

        input.scheduleTitleTextDidChange
            .subscribe(onNext: { text in
                self.currentTitleText.accept(text)
            })
            .disposed(by: disposeBag)

        input.scheduleDateDidChange
            .subscribe(onNext: { date in
                self.currentDate.accept(date)
            })
            .disposed(by: disposeBag)

        input.scheduleBodyTextDidChange
            .subscribe(onNext: { text in
                self.currentBodyText.accept(text)
            })
            .disposed(by: disposeBag)

        input.viewDidDisappear
            .subscribe(onNext: { _ in
                self.useCase.currentSchedule.accept(nil)
            })
            .disposed(by: disposeBag)

        return output
    }
}

private extension ScheduleItemViewModel {
    func bindOutput(output: Output, disposeBag: DisposeBag) {
        self.useCase.currentSchedule
            .flatMap { Observable.from(optional: $0) }
            .subscribe(onNext: { schedule in
                output.scheduleTitleText.accept(schedule.title)
                output.scheduleDate.accept(schedule.dueDate)
                output.scheduleBodyText.accept(schedule.body)
                output.scheduleProgress.accept(schedule.progress.description)
            })
            .disposed(by: disposeBag)

        self.mode
            .subscribe(onNext: { mode in
                switch mode {
                case .detail:
                    output.editable.accept(false)
                    output.leftBarButtonText.accept("수정")
                    output.rightBarButtonText.accept("완료")
                case .edit, .create:
                    output.editable.accept(true)
                    output.leftBarButtonText.accept("취소")
                    output.rightBarButtonText.accept("완료")
                }
            })
            .disposed(by: disposeBag)

        self.currentValidity
            .subscribe(onNext: { bool in
                output.isValid.accept(bool)
            })
            .disposed(by: disposeBag)
    }
}
