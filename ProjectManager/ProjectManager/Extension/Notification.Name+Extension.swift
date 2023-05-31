//
//  Notification.Name+Extension.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/24.
//

import Foundation

extension Notification.Name {
    static var changedTasks = Notification.Name("changedTasks")
    static var updatedTask = Notification.Name("updatedTask")
    static var errorTask = Notification.Name("errorTask")
}
