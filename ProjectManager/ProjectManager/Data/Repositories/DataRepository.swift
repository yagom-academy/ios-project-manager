//
//  DataRepository.swift
//  ProjectManager
//
//  Created by 이승재 on 2022/03/04.
//

import RxSwift

class DataRepository: Repository {

    var dataSource: DataSource

    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }

    func fetch() -> Observable<[Schedule]> {
        return dataSource.fetch()
    }

    func create(_ schedule: Schedule) -> Observable<Schedule> {
        return dataSource.create(schedule)
    }

    func delete(_ scheduleID: UUID) -> Observable<Bool> {
        return dataSource.delete(scheduleID)
    }

    func update(_ schedule: Schedule) -> Observable<Schedule> {
        return dataSource.update(schedule)
    }
}
