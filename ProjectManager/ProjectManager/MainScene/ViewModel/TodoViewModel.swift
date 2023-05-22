//
//  TodoViewModel.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/22.
//

import Foundation

final class TodoViewModel {
    func restrictNumberOfText(range: NSRange, text: String) -> Bool {
        guard let convertedText = text.cString(using: .utf8) else { return false }
        
        let backspaceValue = strcmp(convertedText, "\\b")
        
        guard range.upperBound < 999 ||
              backspaceValue == -92 else { return false }
        
        return true
    }
    
    func makeTask(title: String?, description: String?, date: Date) throws -> Task {
        guard let title = title,
              title != "" else { throw GeneratedTaskError.titleEmpty }
        guard let description = description,
              description != "" else { throw GeneratedTaskError.descriptionEmpty }
        
        return Task(title: title, description: description, date: date)
    }
}
