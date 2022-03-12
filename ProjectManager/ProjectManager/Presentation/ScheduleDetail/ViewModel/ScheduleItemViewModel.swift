//
//  ScheduleDetailViewModel.swift
//  ProjectManager
//
//  Created by Lee Seung-Jae on 2022/03/09.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

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
        let viewDidDisappear: Observable<Void>
    }

    struct Output {
        let scheduleProgress: Driver<String>
        let scheduleTitleText: Driver<String>
        let scheduleDate: Driver<Date>
        let scheduleBodyText: Driver<String>
        let leftBarButtonText: Driver<String>
        let rightBarButtonText: Driver<String>
        let editable: Driver<Bool>
        let isValid: Driver<Bool>
    }

    // MARK: - Methods

    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        [
            self.onLeftBarButtonDidTap(input.leftBarButtonDidTap),
            self.onRightBarButtonDidTap(input.rightBarButtonDidTap),
            self.onScheduleTitleTextDidChange(input.scheduleTitleTextDidChange),
            self.onScheduleDateDidChange(input.scheduleDateDidChange),
            self.onScheduleBodyTextDidChange(input.scheduleBodyTextDidChange),
            self.onViewDidDisappear(input.viewDidDisappear)
        ]
            .forEach { $0.disposed(by: disposeBag)}

        return bindOutput(disposeBag: disposeBag)
    }
}

private extension ScheduleItemViewModel {

    func onLeftBarButtonDidTap(_ input: Observable<Void>) -> Disposable {
        return input
            .subscribe(onNext: { _ in
                switch self.mode.value {
                case .detail:
                    self.currentTitleText.accept(self.useCase.currentSchedule.value?.title ?? "")
                    self.mode.accept(.edit)
                case .edit:
                    self.coordinator.dismiss()
                case .create:
                    guard let schedule = self.useCase.currentSchedule.value else {
                        return
                    }
                    self.useCase.setCurrentSchedule(schedule: schedule)
                    self.mode.accept(.detail)
                }
            })
    }

    func onRightBarButtonDidTap(_ input: Observable<Void>) -> Disposable {
        return input
            .subscribe(onNext: { _ in
                switch self.mode.value {
                case .detail:
                    self.coordinator.dismiss()
                case .edit:guard let schedule = self.useCase.currentSchedule.value else { return }
                    let newSchedule = Schedule(
                        id: schedule.id,
                        title: self.currentTitleText.value,
                        body: self.currentBodyText.value,
                        dueDate: self.currentDate.value,
                        progress: schedule.progress)

                    self.useCase.update(newSchedule)
                    self.coordinator.dismiss()
                case .create:let newSchedule = Schedule(
                    title: self.currentTitleText.value,
                    body: self.currentBodyText.value,
                    dueDate: self.currentDate.value,
                    progress: .todo)
                    self.useCase.create(newSchedule)
                    self.coordinator.dismiss()
                }
            })
    }

    func onScheduleTitleTextDidChange(_ input: Observable<String>) -> Disposable {
        return input
            .bind(to: self.currentTitleText)
    }

    func onScheduleDateDidChange(_ input: Observable<Date>) -> Disposable {
        return input
            .bind(to: self.currentDate)
    }

    func onScheduleBodyTextDidChange(_ input: Observable<String>) -> Disposable {
        return input
            .bind(to: self.currentBodyText)
    }

    func onViewDidDisappear(_ input: Observable<Void>) -> Disposable {
        return input
            .map { nil }
            .bind(to: self.useCase.currentSchedule)
    }

    func bindOutput(disposeBag: DisposeBag) -> Output {

        let scheduleTitleText = self.useCase.currentSchedule
            .flatMap { Observable.from(optional: $0) }
            .map { $0.title }
            .asDriver(onErrorJustReturn: "제목을 표시할 수 없습니다.")

        let scheduleDate = self.useCase.currentSchedule
            .flatMap { Observable.from(optional: $0) }
            .map { $0.dueDate }
            .asDriver(onErrorJustReturn: Date())

        let scheduleBodyText = self.useCase.currentSchedule
            .flatMap { Observable.from(optional: $0) }
            .map { $0.body }
            .asDriver(onErrorJustReturn: "내용을 표시할 수 없습니다")

        let scheduleProgress = self.useCase.currentSchedule
            .flatMap { Observable.from(optional: $0) }
            .map { $0.progress.description}
            .asDriver(onErrorJustReturn: Progress.todo.description)

        let editable = self.mode
            .map { mode -> Bool in
                switch mode {
                case .detail:
                    return false
                case .edit, .create:
                    return true
                }
            }.asDriver(onErrorJustReturn: false)

        let leftBarButtonText = self.mode
            .map { mode -> String in
                switch mode {
                case .detail:
                    return "수정"
                case .edit, .create:
                    return "취소"
                }
            }.asDriver(onErrorJustReturn: "취소")

        let rightBarButtonText = self.mode
            .map { mode -> String in
                switch mode {
                case .detail:
                    return "완료"
                case .edit, .create:
                    return "완료"
                }
            }.asDriver(onErrorJustReturn: "완료")

        let isValid = Observable.combineLatest(
            currentTitleText.map { !$0.isEmpty },
            currentBodyText.map { !$0.isEmpty },
            self.mode.map { $0 == .detail },
            resultSelector: { $0 && $1 || $2 }
        )
            .asDriver(onErrorJustReturn: false)

        return Output(
            scheduleProgress: scheduleProgress,
            scheduleTitleText: scheduleTitleText,
            scheduleDate: scheduleDate,
            scheduleBodyText: scheduleBodyText,
            leftBarButtonText: leftBarButtonText,
            rightBarButtonText: rightBarButtonText,
            editable: editable,
            isValid: isValid
        )
    }
}
