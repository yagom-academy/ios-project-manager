//
//  TodoViewModel.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/22.
//

import UIKit

final class TodoViewModel {
    var state: TodoState
    var task: Task?
    
    var leftBarButtonItem: UIBarButtonItem.SystemItem {
        switch state {
        case .create:
            return .cancel
        case .edit:
            return .edit
        }
    }
    
    var title: String? {
        return task?.title
    }
    
    var description: String? {
        return task?.description
    }
    
    var date: Date? {
        return task?.date
    }
    
    init(state: TodoState, task: Task? = nil) {
        self.state = state
        self.task = task
    }
    
    func restrictNumberOfText(range: NSRange, text: String) -> Bool {
        guard let convertedText = text.cString(using: .utf8) else { return false }
        
        let backspaceValue = strcmp(convertedText, "\\b")
        
        guard range.upperBound < 999 || backspaceValue == -92 else { return false }
        return true
    }
    
    func makeTask(title: String?, description: String?, date: Date) throws {
        guard let title = title, title != "" else {
            throw GeneratedTaskError.titleEmpty
        }
        guard let description = description, description != "" else {
            throw GeneratedTaskError.descriptionEmpty
        }
        
        self.task = Task(id: UUID(), title: title, description: description, date: date)
    }
    
    func editTask(title: String?, description: String?, date: Date) throws {
        guard let title = title, title != "" else {
            throw GeneratedTaskError.titleEmpty
        }
        guard let description = description, description != "" else {
            throw GeneratedTaskError.descriptionEmpty
        }
        
        self.task?.title = title
        self.task?.description = description
        self.task?.date = date
    }
}
