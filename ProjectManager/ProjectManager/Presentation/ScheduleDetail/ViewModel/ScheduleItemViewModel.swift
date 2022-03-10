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
    let mode: BehaviorRelay<Mode>
    let currentTitleText = BehaviorRelay<String>(value: "")
    let currentDate = BehaviorRelay<Date>(value: Date())
    let currentBodyText = BehaviorRelay<String>(value: "")

    // MARK: - Properties

    private let bag = DisposeBag()
    private let useCase: ScheduleUseCase
    private let coordinator: ScheduleItemCoordinator

    // MARK: - Initializer

    init(useCase: ScheduleUseCase, coordinator: ScheduleItemCoordinator, mode: Mode) {
        self.useCase = useCase
        self.coordinator = coordinator
        self.mode = BehaviorRelay<Mode>(value: mode)
    }

    struct Input {
        let leftBarButtonDidTap: Observable<Void>
        let rightBarButtonDidTap: Observable<Void>
        let scheduleTitleTextDidChange: Observable<String>
        let scheduleDateDidChange: Observable<Date>
        let scheduleBodyTextDidChange: Observable<String>
    }

    struct Output {
        let scheduleProgress = BehaviorRelay<String>(value: "")
        let scheduleTitleText = BehaviorRelay<String>(value: "")
        let scheduleDate = BehaviorRelay<Date>(value: Date())
        let scheduleBodyText = BehaviorRelay<String>(value: "")
        let leftBarButtonText = BehaviorRelay<String>(value: "")
        let rightBarButtonText = BehaviorRelay<String>(value: "")
        let editable = BehaviorRelay<Bool>(value: false)
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
                    self.useCase.setCurrentSchedule(schedule: self.useCase.currentSchedule.value)
                    self.mode.accept(.detail)
                case .create:
                    self.coordinator.dismiss()
                }
            })
            .disposed(by: disposeBag)

        input.rightBarButtonDidTap
            .subscribe(onNext: { schedule in
                switch self.mode.value {
                case .detail:
                    self.coordinator.dismiss()
                case .edit:
                    let schedule = Schedule(
                        id: self.useCase.currentSchedule.value.id!,
                        title: self.currentTitleText.value,
                        body: self.currentBodyText.value,
                        dueDate: self.currentDate.value,
                        progress: self.useCase.currentSchedule.value.progress)
                    self.useCase.update(schedule)
                    self.coordinator.dismiss()
                case .create:
                    let schedule = Schedule(
                        id: self.useCase.currentSchedule.value.id!,
                        title: self.currentTitleText.value,
                        body: self.currentBodyText.value,
                        dueDate: self.currentDate.value,
                        progress: .todo)
                    self.useCase.create(schedule)
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

        return output
    }
}

private extension ScheduleItemViewModel {
    func bindOutput(output: Output, disposeBag: DisposeBag) {
        self.useCase.currentSchedule
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
    }
}
