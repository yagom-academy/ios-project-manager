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
    
    private var content: String = Constant.defaultText {
        didSet {
            contentHandler?(content)
        }
    }
    
    private var isEdiatable = false {
        didSet {
            editableHandler?(isEdiatable)
        }
    }
    
    private var titleHandler: ((String) -> Void)?
    private var dateHandler: ((Date) -> Void)?
    private var contentHandler: ((String) -> Void)?
    private var editableHandler: ((Bool) -> Void)?
    
    init(data: Plan?) {
        guard let data = data else {
            mode = .new
            isEdiatable = true
            return
        }
        self.title = data.title
        self.date = data.deadLine ?? Date()
        self.content = data.content ?? Constant.defaultText
        mode = .edit
    }
}

// MARK: - Method
extension DetailViewModel {
    func isNewMode() -> Bool {
        return mode == .new
    }
    
    func bindTitle(handler: @escaping (String) -> Void) {
        handler(title)
        self.titleHandler = handler
    }
    
    func bindDate(handler: @escaping (Date) -> Void) {
        handler(date)
        self.dateHandler = handler
    }
    
    func bindContent(handler: @escaping (String) -> Void) {
        handler(content)
        self.contentHandler = handler
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
    
    func createData(title: String, content: String?, date: Date?) -> Plan {
        return Plan(title: title, content: content, deadLine: date)
    }
}
