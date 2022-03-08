//
//  ArrayDataSource.swift
//  ProjectManager
//
//  Created by Jae-hoon Sim on 2022/03/04.
//

import Foundation
import RxSwift

final class MemoryDataSource: DataSource {
    var storage = [Schedule]()

    func rxFetch() -> Observable<[Schedule]> {
        return Observable.create { emitter in
            self.fetch() { result in
                emitter.onNext(result)
            }
            return Disposables.create()
        }
    }

    func rxCreate(_ schedule: Schedule) -> Observable<Schedule> {
        return Observable.create { emitter in
            self.create(schedule) { result in
                emitter.onNext(result)
            }
            return Disposables.create()
        }
    }

    func rxDelete(_ scheduleID: UUID) -> Observable<Bool> {
        return Observable.create { emitter in
            self.delete(scheduleID) { result in
                emitter.onNext(result)
            }
            return Disposables.create()
        }
    }

    func rxUpdate(_ schedule: Schedule) -> Observable<Schedule> {
        return Observable.create { emitter in
            self.update(schedule) { result in
                switch result {
                case .none:
                    emitter.onCompleted()
                case .some(let schedule):
                    emitter.onNext(schedule)
                }
            }
            return Disposables.create()
        }
    }

}

private extension MemoryDataSource {
    func fetch(completion: ([Schedule]) -> Void) {
        completion(storage)
    }

    func create(_ schedule: Schedule, completion: (Schedule) -> Void) {
        storage.append(schedule)
        completion(schedule)
    }

    func delete(_ scheduleID: UUID, completion: (Bool) -> Void) {
        let index = storage.enumerated().filter { idx, schedule in
            schedule.id == scheduleID
        }.map { element in
            element.0
        }.first

        guard let index = index else {
            completion(false)
            return
        }
        storage.remove(at: index)
        completion(true)
    }

    func update(_ schedule: Schedule, completion: (Schedule?) -> Void) {
        let index = storage.enumerated().filter { idx, schedule in
            schedule.id == schedule.id
        }.map { element in
            element.0
        }.first

        guard let index = index else {
            completion(nil)
            return
        }
        storage[index] = schedule
        completion(storage[index])
    }
}
