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

    var remoteDataSource: NetworkService

    init(dataSource: DataSource, remoteDataSource: NetworkService) {
        self.dataSource = dataSource
        self.remoteDataSource = remoteDataSource
    }

    func fetch() -> Observable<[Schedule]> {
        return self.remoteDataSource.fetch()
//        return self.dataSource.rxFetch()
    }

    func create(_ schedule: Schedule) -> Observable<Schedule> {
        return self.remoteDataSource.create(schedule)
//        return self.dataSource.rxCreate(schedule)
    }

    func delete(_ scheduleID: UUID) -> Observable<Bool> {
        return self.dataSource.rxDelete(scheduleID)
    }

    func update(_ schedule: Schedule) -> Observable<Schedule> {
        return self.dataSource.rxUpdate(schedule)
    }
}
