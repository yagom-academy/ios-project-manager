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

class MainViewModel {

    let useCase: ScheduleUseCase
    let bag = DisposeBag()

    //MARK: - Input
    let scheduleList = BehaviorRelay<[Schedule]>(value: [])

    //MARK: - Output
    var schedules: Driver<[[Schedule]]>

    init(useCase: ScheduleUseCase) {
        self.useCase = useCase
        self.schedules = scheduleList.map { schedules in
            schedules
                .reduce([[Schedule](), [Schedule](), [Schedule]()]) { partialResult, schedule in
                    var new = partialResult
                    switch schedule.progress {
                    case .todo:
                        new[0].append(schedule)
                    case .doing:
                        new[1].append(schedule)
                    case .done:
                        new[2].append(schedule)
                    }
                    return new
                }
        }
        .asDriver(onErrorJustReturn: [[]])
    }

    func fetch() {
        useCase.fetch()
            .subscribe { event in
                self.scheduleList.accept(event)
            }
            .disposed(by: bag)
    }

    func delete(id: UUID) {
        self.useCase.delete(id)
            .filter { $0 }
            .subscribe(onNext: { _ in
                let schedules = self.scheduleList.value.filter { schedule in
                    schedule.id != id
                }
                self.scheduleList.accept(schedules)
            })
            .disposed(by: bag)
    }
}

extension Schedule {

    var formattedDateString: String {
        return DateFormatter.dueDate.string(from: self.dueDate)
    }
}
