//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by Jae-hoon Sim on 2022/03/08.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

final class MainViewModel {

    // MARK: - Properties

    private let bag = DisposeBag()
    private let useCase: ScheduleUseCase

    // MARK: - Initializer

    init(useCase: ScheduleUseCase) {
        self.useCase = useCase
    }

    struct Input {
        let viewWillAppear: Observable<Void>
        let cellDidTap: [Observable<Schedule>]
        let cellDelete: [Observable<UUID>]
        let addButtonDidTap: Observable<Void>
    }

    struct Output {
        let scheduleLists = [
            BehaviorRelay<[Schedule]>(value: []),
            BehaviorRelay<[Schedule]>(value: []),
            BehaviorRelay<[Schedule]>(value: [])
        ]
    }

    // MARK: - Methods

    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()

        input.viewWillAppear
            .subscribe(onNext: {
                self.useCase.fetch()
                    .subscribe(onNext: { event in
                        Progress.allCases.enumerated().forEach { index, progress in
                            let filtered = event.filter { schedule in schedule.progress == progress }
                            output.scheduleLists[index].accept(filtered)
                        }
                    })
                    .disposed(by: self.bag)
            })
            .disposed(by: disposeBag)

        input.cellDelete.enumerated().forEach { index, observable in
            observable.subscribe(onNext: { id in
                self.useCase.delete(id)
                    .filter { $0 }
                    .subscribe(onNext: { _ in
                        let schedules = output.scheduleLists[index].value.filter { schedule in
                            schedule.id != id
                        }
                        output.scheduleLists[index].accept(schedules)
                    })
                    .disposed(by: self.bag)
            })
                .disposed(by: disposeBag)
        }

        return output
    }
}

extension Schedule {

    var formattedDateString: String {
        return DateFormatter.dueDate.string(from: self.dueDate)
    }
}
