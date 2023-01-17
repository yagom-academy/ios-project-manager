//
//  DetailViewModel.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/14.
//

import Foundation

final class DetailViewModel {
    private enum Constant {
        static let defaultText = ""
    }
    
    private enum Mode {
        case new
        case edit
    }
    
    private var mode: Mode?
    
    private var title: String = Constant.defaultText {
        didSet {
            titleHandler?(title)
        }
    }
    
    private var date: Date = Date() {
        didSet {
            dateHandler?(date)
        }
    }
    
    private var description: String = Constant.defaultText {
        didSet {
            descriptionHandler?(description)
        }
    }
    
    private var isEdiatable = false {
        didSet {
            editableHandler?(isEdiatable)
        }
    }
    
    private var titleHandler: ((String) -> Void)?
    private var dateHandler: ((Date) -> Void)?
    private var descriptionHandler: ((String) -> Void)?
    private var editableHandler: ((Bool) -> Void)?
    
    init(data: Todo?) {
        guard let data = data else {
            mode = .new
            isEdiatable = true
            return
        }
        self.title = data.title
        self.date = data.deadLine ?? Date()
        self.description = data.content ?? Constant.defaultText
        mode = .edit
    }
    
    func isNewMode() -> Bool {
        if mode == .new {
            return true
        } else {
            return false
        }
    }
    
    func bindTitle(handler: @escaping (String) -> Void) {
        handler(title)
        self.titleHandler = handler
    }
    
    func bindDate(handler: @escaping (Date) -> Void) {
        handler(date)
        self.dateHandler = handler
    }
    
    func bindDescription(handler: @escaping (String) -> Void) {
        handler(description)
        self.descriptionHandler = handler
    }
    
    func bindEditable(handler: @escaping (Bool) -> Void) {
        handler(isEdiatable)
        self.editableHandler = handler
    }
    
    func fetchEditable() -> Bool {
        return isEdiatable
    }
    
    func toggle() {
        isEdiatable.toggle()
    }
    
    func createData(title: String, content: String?, date: Date?) -> Todo {
        return Todo(title: title, content: content, deadLine: date)
    }
}
