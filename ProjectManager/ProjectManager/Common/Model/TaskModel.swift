//
//  TaskModel.swift
//  ProjectManager
//
//  Created by seohyeon park on 2022/09/12.
//

import Foundation
import UIKit

struct TaskModel {
    var taskTitle: String = ""
    var taskDescription: String = ""
    var taskDeadline: String = ""
    var taskState: String = TaskState.todo.name
    var id: UUID = UUID()
    var deadLineLabelTextColor: UIColor?
}

extension TaskModel {
    func checkPastDate() -> UIColor {
        let deadline = Int(self.taskDeadline.filter { $0.isNumber }) ?? 0
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let currentDate = Int(formatter.string(from: Date())) ?? 0

        if currentDate > deadline {
            return UIColor.red
        }

        return UIColor.black
    }
}
