//
//  RealmService.swift
//  ProjectManager
//
//  Created by Lee Seung-Jae on 2022/03/16.
//

import Foundation
import RealmSwift
import RxSwift

class RealmService: LocalDatabaseService {
    let database: Realm

    init?() {
        guard let realm = try? Realm() else { return nil }
        self.database = realm
    }

    func fetch() -> Single<[Schedule]> {
        return Single.create { single in
            let storedSchedules = self.database.objects(StorableSchedule.self)
            let schedules = storedSchedules.compactMap { Schedule($0) } as [Schedule]
            single(.success(schedules))
            return Disposables.create()
        }
    }

    func create(_ schedule: Schedule) -> Completable {
        return Completable.create { completable in
            do {
                try self.database.write {
                    self.database.add(schedule.makeStorable())
                }
                completable(.completed)
            } catch let error {
                completable(. error(error))
            }
            return Disposables.create()
        }
    }

    func delete(_ scheduleID: UUID) -> Completable {
        return Completable.create { completable in
            do {
                try self.database.write {

                    let schedule = self.database.objects(StorableSchedule.self).where {
                        $0.id == scheduleID.uuidString
                    }
                    self.database.delete(schedule)
                }
                completable(.completed)
            } catch let error {
                completable(. error(error))
            }
            return Disposables.create()
        }
    }

    func update(_ newSchedule: Schedule) -> Completable {
        return Completable.create { completable in
            do {
                try self.database.write {
                    let schedule = self.database.objects(StorableSchedule.self).where {
                        $0.id == newSchedule.id.uuidString
                    }.first
                    schedule?.title = newSchedule.title
                    schedule?.body = newSchedule.body
                    schedule?.dueDate = newSchedule.dueDate
                    schedule?.progress = newSchedule.progress.description
                }
                completable(.completed)
            } catch let error {
                completable(. error(error))
            }
            return Disposables.create()
        }
    }
}

private extension Schedule {

    private var storableSchedule: StorableSchedule {
        let storableSchedule = StorableSchedule()
        storableSchedule.id = self.id.uuidString
        storableSchedule.title = self.title
        storableSchedule.body = self.body
        storableSchedule.dueDate = self.dueDate
        storableSchedule.progress = self.progress.description

        return storableSchedule
    }

    func makeStorable() -> StorableSchedule {
        return self.storableSchedule
    }

    init?(_ storableSchedule: StorableSchedule) {
        guard let id = UUID(uuidString: storableSchedule.id),
              let progress = Progress(rawValue: storableSchedule.progress)
        else {
            return nil
        }

        self.id = id
        self.title = storableSchedule.title
        self.body = storableSchedule.body
        self.dueDate = storableSchedule.dueDate
        self.lastUpdated = storableSchedule.lastUpdated
        self.progress = progress
    }
}
