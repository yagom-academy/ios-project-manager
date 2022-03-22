//
//  DataRepository.swift
//  ProjectManager
//
//  Created by 이승재 on 2022/03/04.
//

import Foundation
import RxSwift
import Network

final class DefaultScheduleRepository: ScheduleRepository {

    private var localDataSource: LocalDatabaseService
    private var remoteDataSource: NetworkService
    private var isConnected = true
    private let bag = DisposeBag()

    init(dataSource: LocalDatabaseService, remoteDataSource: NetworkService) {
        self.localDataSource = dataSource
        self.remoteDataSource = remoteDataSource
        self.binding()
    }

    private func binding() {
        NetworkChecker.shared.isConnected
            .subscribe(onNext: { isConnected in
                self.isConnected = isConnected
            })
            .disposed(by: self.bag)
    }

    func fetch() -> Single<[Schedule]> {
        if isConnected {
            return self.syncronize()
                .andThen(self.remoteDataSource.fetch())
        } else {
            return self.localDataSource.fetch()
        }
    }

    func syncronize() -> Completable {
        return Single.zip(
            self.localDataSource.fetch(),
            self.remoteDataSource.fetch()
        ).map { local, remote -> Completable in
            let localIDSet = Set(local.map { $0.id })
            let remoteIDSet = Set(remote.map { $0.id })
            let differenceFromLocalIDToRemoteID = localIDSet.subtracting(remoteIDSet)
            let differenceFromLocalToRemote = local
                .filter { differenceFromLocalIDToRemoteID.contains($0.id) }
            let remoteCreatesCompletable = Completable.zip(differenceFromLocalToRemote.map {
                self.remoteDataSource.create($0)
            })
            let differenceFromRemoteToLocal = remoteIDSet.subtracting(localIDSet)
            let remoteDeletesCompletable = Completable.zip(differenceFromRemoteToLocal.map {
                self.remoteDataSource.delete($0)
            })

            let idIntersection = localIDSet.intersection(remoteIDSet)
            let localIntersection = local.filter { idIntersection.contains($0.id) }
            let remoteIntersection = remote.filter { idIntersection.contains($0.id)}

            let remoteUpdatesCompletable = Completable.zip(
                remoteIntersection.flatMap { remoteSchedule in
                    localIntersection.filter { localSchedule in
                        localSchedule.id == remoteSchedule.id &&
                        localSchedule.lastUpdated > remoteSchedule.lastUpdated
                    }.map { self.remoteDataSource.update($0) }
                }
            )

            return Completable.zip(
                remoteCreatesCompletable,
                remoteDeletesCompletable,
                remoteUpdatesCompletable
            )
        }.flatMapCompletable { $0 }
    }

    func create(_ schedule: Schedule) -> Completable {
        if self.isConnected {
            return Completable.zip(
                self.localDataSource.create(schedule),
                self.remoteDataSource.create(schedule)
            )
        }

        return self.localDataSource.create(schedule)
    }

    func delete(_ scheduleID: UUID) -> Completable {
        if self.isConnected {
            return Completable.zip(
                self.localDataSource.delete(scheduleID),
                self.remoteDataSource.delete(scheduleID)
            )
        }

        return self.localDataSource.delete(scheduleID)
    }

    func update(_ schedule: Schedule) -> Completable {
        if self.isConnected {
            return Completable.zip(
                self.localDataSource.update(schedule),
                self.remoteDataSource.update(schedule)
            )
        }

        return self.localDataSource.update(schedule)
    }
}
