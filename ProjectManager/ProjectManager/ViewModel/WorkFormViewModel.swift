//
//  WorkFormViewModel.swift
//  ProjectManager
//
//  Created by leewonseok on 2023/01/17.
//

import UIKit

final class WorkFormViewModel {
    var work: Work? {
        didSet {
            guard let work else { return }
            workHandler?(work)
        }
    }
    
    var isEdit: Bool {
        didSet {
            isEditHandler?(isEdit)
            colorHandler?(checkEditColor(isEdit: isEdit))
        }
    }
    private var workHandler: ((Work) -> Void)?
    private var isEditHandler: ((Bool) -> Void)?
    private var colorHandler: ((UIColor) -> Void)?
    
    func bindWork(handler: @escaping (Work) -> Void) {
        workHandler = handler
    }
    
    func bindIsEdit(handler: @escaping (Bool) -> Void) {
        isEditHandler = handler
    }
    
    func bindTextColor(handler: @escaping (UIColor) -> Void) {
        colorHandler = handler
    }
    
    init(work: Work? = nil, isEdit: Bool = true) {
        self.work = work
        self.isEdit = isEdit
    }
    
    func load() {
        if let work {
            workHandler?(work)
        }
        isEditHandler?(isEdit)
    }
    
    func toggleEdit() {
        isEdit.toggle()
    }
    
    func checkEditColor(isEdit: Bool) -> UIColor {
        if isEdit {
            return .black
        } else {
            return .systemGray3
        }
    }
    
    func updateWork(title: String?, body: String?, date: Date) -> Work? {
        if let work {
            self.work = Work(id: work.id, category: work.category, title: title, body: body, endDate: date)
        } else {
            work = Work(category: .todo, title: title, body: body, endDate: date)
        }
        return work
    }
}
