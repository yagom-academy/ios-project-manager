//
//  Repository.swift
//  ProjectManager
//
//  Created by 이승재 on 2022/03/04.
//

import RxSwift

protocol Repository {

    func fetch() -> Observable<[Schedule]>

    func create(_ schedule: Schedule) -> Observable<Schedule>

    func delete(_ scheduleID: UUID) -> Observable<Bool>

    func update(_ schedule: Schedule) -> Observable<Schedule>
}
