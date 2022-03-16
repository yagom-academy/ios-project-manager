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

    func fetch() -> Single<[Schedule]> {

        return self.remoteDataSource.fetch()
    }

    func create(_ schedule: Schedule) -> Completable {
        return self.remoteDataSource.create(schedule)
    }

    func delete(_ scheduleID: UUID) -> Completable {
        return self.remoteDataSource.delete(scheduleID)
    }

    func update(_ schedule: Schedule) -> Completable {
        return self.remoteDataSource.update(schedule)
    }
}
