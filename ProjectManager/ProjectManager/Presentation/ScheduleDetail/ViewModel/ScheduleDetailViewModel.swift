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

class ScheduleDetailViewModel {

    // MARK: - Properties

    private let bag = DisposeBag()
    private let useCase: ScheduleUseCase

    // MARK: - Initializer

    init(useCase: ScheduleUseCase) {
        self.useCase = useCase
    }

    struct Input {
        let leftBarButtonDidTap: Observable<Void>
        let rightBarButtonDidTap: Observable<Void>
        let textViewDidChange: Observable<String>
    }

    struct Output {
        let scheduleTitleText = BehaviorRelay<String>(value: "")
        let scheduleDate = BehaviorRelay<Date>(value: Date())
        let scheduleBodyText = BehaviorRelay<String>(value: "")
    }

    // MARK: - Methods

    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()

        input.leftBarButtonDidTap
            .subscribe(onNext: { _ in

            })
            .disposed(by: disposeBag)

        input.rightBarButtonDidTap
            .subscribe(onNext: { _ in

            })
            .disposed(by: disposeBag)

        input.textViewDidChange
            .subscribe(onNext: { string in
                var string = string
                if string.count >= 1000 {
                    string.removeLast()
                }
                output.scheduleBodyText.accept(string)
            })
            .disposed(by: disposeBag)

        return output
    }
}
