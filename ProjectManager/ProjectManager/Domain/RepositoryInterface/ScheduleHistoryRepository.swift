//
//  ScheduleHistoryRepository.swift
//  ProjectManager
//
//  Created by Lee Seung-Jae on 2022/03/22.
//

import Foundation

protocol ScheduleHistoryRepository {
    func excuteAndRecode(action: ScheduleAction)
    func undo()
    func redo()
}
