//
//  NetworkService.swift
//  ProjectManager
//
//  Created by Lee Seung-Jae on 2022/03/16.
//

import Foundation
import RxSwift

protocol NetworkService {
    func fetch() -> Single<[Schedule]>
    func create(_ schedule: Schedule) -> Completable
    func delete(_ scheduleID: UUID) -> Completable
    func update(_ schedule: Schedule) -> Completable
}
