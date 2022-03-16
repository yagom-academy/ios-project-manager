//
//  DataSource.swift
//  ProjectManager
//
//  Created by 이승재 on 2022/03/04.
//

import Foundation
import RxSwift

protocol LocalDatabaseService {
    func fetch() -> Single<[Schedule]>
    func create(_ schedule: Schedule) -> Completable
    func delete(_ scheduleID: UUID) -> Completable
    func update(_ newSchedule: Schedule) -> Completable
}
