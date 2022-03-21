//
//  TaskCell.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/14.
//

import Foundation

struct TaskCellViewModel {
    var title: String
    var description: String
    var state: TaskState
    var deadline: NSAttributedString
    
    init(title: String, description: String, state: TaskState, deadline: Date) {
        self.title = title
        self.description = description
        self.state = state
        self.deadline = Self.dateToNSAttributedString(from: deadline, with: state)
    }
    
    private static func dateToNSAttributedString(from date: Date, with state: TaskState) -> NSAttributedString {
        if [.waiting, .progress].contains(state) && date < Date() {
            return NSAttributedString(string: date.dateString, attributes: TextAttribute.overDeadline)
        } else {
            return NSAttributedString(string: date.dateString, attributes: TextAttribute.underDeadline)
        }
    }
}

private extension Date {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.locale = .current
        return dateFormatter
    }()
    
    var dateString: String {
        return Self.dateFormatter.string(from: self)
    }
}
