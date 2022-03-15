//
//  DataRepository.swift
//  ProjectManager
//
//  Created by 이승재 on 2022/03/04.
//

import Foundation
import RxSwift

final class DataRepository: Repository {

    var dataSource: DataSource

    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }

    func fetch() -> Observable<[Schedule]> {
        return self.dataSource.rxFetch()
    }

    func create(_ schedule: Schedule) -> Observable<Schedule> {
        return self.dataSource.rxCreate(schedule)
    }

    func delete(_ scheduleID: UUID) -> Observable<Bool> {
        return self.dataSource.rxDelete(scheduleID)
    }

    func update(_ schedule: Schedule) -> Observable<Schedule> {
        return self.dataSource.rxUpdate(schedule)
    }
}
