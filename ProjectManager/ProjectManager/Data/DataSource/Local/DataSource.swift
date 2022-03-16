//
//  DataSource.swift
//  ProjectManager
//
//  Created by 이승재 on 2022/03/04.
//

import Foundation
import RxSwift

protocol DataSource {

    func rxFetch() -> Observable<[Schedule]>

    func rxCreate(_ schedule: Schedule) -> Observable<Schedule>

    func rxDelete(_ scheduleID: UUID) -> Observable<Bool>

    func rxUpdate(_ schedule: Schedule) -> Observable<Schedule>
}
