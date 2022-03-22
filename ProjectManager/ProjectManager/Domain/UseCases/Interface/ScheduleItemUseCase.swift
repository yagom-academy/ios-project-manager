//
//  ScheduleItemUseCase.swift
//  ProjectManager
//
//  Created by Jae-hoon Sim on 2022/03/16.
//

import Foundation
import RxRelay

protocol ScheduleItemUseCase {
    var currentSchedule: BehaviorRelay<Schedule?> { get }
    func create(_ schedule: Schedule)
    func update(_ schedule: Schedule)
    func delete(_ scheduleID: UUID)
}
