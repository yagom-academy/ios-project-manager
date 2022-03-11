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

    }
}
