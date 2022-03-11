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

        let currentProgress = self.useCase.currentSchedule.value?.progress
        let targetProgressSet = Progress.allCases.filter { $0 != currentProgress }

        input.topButtonDidTap
            .subscribe(onNext: {
                guard let topButtonProgress = targetProgressSet.first else { return }
                self.useCase.changeProgress(progress: topButtonProgress)
                self.coordinator.dismiss()
            })
            .disposed(by: disposeBag)

        input.bottomButtonDidTap
            .subscribe(onNext: {
                guard let bottomButtonProgress = targetProgressSet.last else { return }
                self.useCase.changeProgress(progress: bottomButtonProgress)
                self.coordinator.dismiss()
            })
            .disposed(by: disposeBag)

        input.viewDidDisappear
            .subscribe(onNext: { _ in
                self.useCase.currentSchedule.accept(nil)
            })
            .disposed(by: disposeBag)

        return bindOutput()
    }
}

private extension PopoverViewModel {
    func bindOutput() -> Output {
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
