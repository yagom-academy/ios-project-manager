//
//  MainUseCase.swift
//  ProjectManager
//
//  Created by Jae-hoon Sim on 2022/03/16.
//

import Foundation
import RxSwift
import RxRelay

protocol MainUseCase {
    var schedules: BehaviorRelay<[Schedule]> { get }
    var currentSchedule: BehaviorRelay<Schedule?> { get }
    func fetch()
    func create(_ schedule: Schedule)
    func delete(_ scheduleID: UUID)
    func changeProgress(of schedule: Schedule, progress: Progress?)
}
