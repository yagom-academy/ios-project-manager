//
//  DataRepository.swift
//  ProjectManager
//
//  Created by 이승재 on 2022/03/04.
//

import Foundation
import RxSwift
import Network

final class DataRepository: Repository {

    var dataSource: LocalDatabaseService
    var remoteDataSource: NetworkService
    let networkMonitor = NWPathMonitor()

    init(dataSource: LocalDatabaseService, remoteDataSource: NetworkService) {
        self.dataSource = dataSource
        self.remoteDataSource = remoteDataSource
    }

    func fetch() -> Single<[Schedule]> {
        return self.dataSource.fetch()
        //return self.remoteDataSource.fetch()
    }

    func create(_ schedule: Schedule) -> Completable {
        return self.dataSource.create(schedule)

        //return self.remoteDataSource.create(schedule)
    }

    func delete(_ scheduleID: UUID) -> Completable {
        return self.dataSource.delete(scheduleID)
        //return self.remoteDataSource.delete(scheduleID)
    }

    func update(_ schedule: Schedule) -> Completable {
        return self.dataSource.update(schedule)
        //return self.remoteDataSource.update(schedule)
    }
}
