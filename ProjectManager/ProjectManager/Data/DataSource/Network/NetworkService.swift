//
//  NetworkService.swift
//  ProjectManager
//
//  Created by Lee Seung-Jae on 2022/03/16.
//

import Foundation
import RxSwift

protocol NetworkService {
    func fetch() -> Observable<[Schedule]>
    func create(_ schedule: Schedule) -> Observable<Schedule>
    func delete(_ scheduleID: UUID)
    func update(_ schedule: Schedule)
}
