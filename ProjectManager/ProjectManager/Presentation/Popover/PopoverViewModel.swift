//
//  PopoverViewModel.swift
//  ProjectManager
//
//  Created by Jae-hoon Sim on 2022/03/11.
//

import RxSwift
import RxRelay
import UIKit

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
        let topButtonTitleText = BehaviorRelay<String>(value: "")
        let bottomButtonTitleText = BehaviorRelay<String>(value: "")
    }

    // MARK: - Methods

    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        bindOutput(output: output, disposeBag: disposeBag)

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

        return output
    }
}

private extension PopoverViewModel {
    func bindOutput(output: Output, disposeBag: DisposeBag) {
        let currentProgress = self.useCase.currentSchedule.value?.progress
        let targetProgressSet = Progress.allCases.filter { $0 != currentProgress }
        guard let topButtonProgress = targetProgressSet.first else { return }
        guard let bottomButtonProgress = targetProgressSet.last else { return }

        output.topButtonTitleText.accept("Move to \(topButtonProgress.description)")
        output.bottomButtonTitleText.accept("Move to \(bottomButtonProgress.description)")
    }
}
