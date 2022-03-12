//
//  PopoverViewModel.swift
//  ProjectManager
//
//  Created by Jae-hoon Sim on 2022/03/11.
//

import RxSwift
import RxRelay
import RxCocoa

class PopoverViewModel {

    // MARK: - Properties
    private let bag = DisposeBag()
    private let useCase: ScheduleUseCase
    private let coordinator: PopoverCoordinator

    // MARK: - Initializer

    init(useCase: ScheduleUseCase, coordinator: PopoverCoordinator) {
        self.useCase = useCase
        self.coordinator = coordinator
    }

    struct Input {
        let topButtonDidTap: Observable<Void>
        let bottomButtonDidTap: Observable<Void>
        let viewDidDisappear: Observable<Void>
    }

    struct Output {
        let topButtonTitleText: Driver<String>
        let bottomButtonTitleText: Driver<String>
    }

    // MARK: - Methods

    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        [
            onTopButtonDidTap(input.topButtonDidTap),
            onBottomButtonDidTap(input.bottomButtonDidTap),
            onViewDidDisappear(input.viewDidDisappear)
        ]
            .forEach { $0.disposed(by: disposeBag) }

        return bindingOutput()
    }
}

private extension PopoverViewModel {

    func onTopButtonDidTap(_ input: Observable<Void>) -> Disposable {
        let currentProgress = self.useCase.currentSchedule.value?.progress
        let targetProgressSet = Progress.allCases.filter { $0 != currentProgress }
        return input
            .do(onNext: self.coordinator.dismiss)
            .flatMap { Observable.from(optional: targetProgressSet.first) }
            .bind(onNext: self.useCase.changeProgress(progress:))
    }

    func onBottomButtonDidTap(_ input: Observable<Void>) -> Disposable {
        let currentProgress = self.useCase.currentSchedule.value?.progress
        let targetProgressSet = Progress.allCases.filter { $0 != currentProgress }
        return input
            .do(onNext: self.coordinator.dismiss)
            .flatMap { Observable.from(optional: targetProgressSet.last) }
            .bind(onNext: self.useCase.changeProgress(progress:))
    }

    func onViewDidDisappear(_ input: Observable<Void>) -> Disposable {
        return input
            .map { nil }
            .bind(to: self.useCase.currentSchedule)
    }

    func bindingOutput() -> Output {
        let topButtonTitleText = self.useCase.currentSchedule.map { (schedule) -> String in
            let targetProgress = Progress.allCases.filter { progress in progress != schedule?.progress }
            return "Move to \(targetProgress.first?.description ?? "")"
        }
        let bottomButtonTitleText = self.useCase.currentSchedule.map { (schedule) -> String in
            let targetProgress = Progress.allCases.filter { progress in progress != schedule?.progress }
            return "Move to \(targetProgress.last?.description ?? "")"
        }
        return Output(topButtonTitleText: topButtonTitleText.asDriver(onErrorJustReturn: ""),
                      bottomButtonTitleText: bottomButtonTitleText.asDriver(onErrorJustReturn: ""))
    }
}
