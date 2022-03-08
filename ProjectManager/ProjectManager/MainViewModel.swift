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

    //MARK: Input
    let scheduleList = BehaviorRelay<[Schedule]>(value: [])


    //MARK: Output

    var schedules: Driver<[Schedule]>

    init(useCase: ScheduleUseCase) {
        self.useCase = useCase
        self.schedules = scheduleList.asDriver()
    }

    func fetch() {
        useCase.fetch()
            .subscribe { event in
                self.scheduleList.accept(event)
            }
            .disposed(by: bag)
    }

    func delete(scheduleID: UUID) {
        useCase.delete(scheduleID)
            .filter { $0 }
            .subscribe(onNext: { result in
                let new = self.scheduleList.value.filter { schedule in
                    schedule.id != scheduleID
                }
                self.scheduleList.accept(new)
            })
            .disposed(by: bag)
    }

}
