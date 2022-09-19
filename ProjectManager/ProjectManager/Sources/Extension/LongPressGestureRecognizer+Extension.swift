//
//  LongPressGestureRecognizer+Extension.swift
//  ProjectManager
//
//  Created by 유한석 on 2022/09/16.
//

import UIKit

class CustomLongPressGesture: UILongPressGestureRecognizer {
    var taskState: ProjectTaskState?
    var cellID: UUID?
}
