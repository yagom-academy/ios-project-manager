//
//  ScheduleAction.swift
//  ProjectManager
//
//  Created by Lee Seung-Jae on 2022/03/22.
//

import Foundation

class ScheduleAction {
    var isUndone: Bool
    let execute: () -> Void
    let reverse: () -> Void

    init(execute: @escaping () -> Void, reverse: @escaping () -> Void) {
        isUndone = false
        self.execute = execute
        self.reverse = reverse
    }
}
