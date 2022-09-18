//
//  Notification.Name+Extension.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/18.
//

import Foundation

extension Notification.Name {
    static let toDoToDoing = Notification.Name("TODOtoDOING")
    static let toDoToDone = Notification.Name("TODOtoDONE")
    static let doingToToDo = Notification.Name("DOINGtoTODO")
    static let doingToDone = Notification.Name("DOINGtoDONE")
    static let doneToToDo = Notification.Name("DONEtoTODO")
    static let doneToDoing = Notification.Name("DONEtoDOING")
}
