//
//  WorkFormViewModel.swift
//  ProjectManager
//
//  Created by leewonseok on 2023/01/17.
//

import Foundation

final class WorkFormViewModel {
    var work: Work? {
        didSet {
            guard work != nil else { return }
            workHandler?(work)
        }
    }
    
    var isEdit: Bool {
        didSet {
            isEditHandler?(isEdit)
        }
    }
    
    var workHandler: ((Work?) -> Void)?
    var isEditHandler: ((Bool) -> Void)?
    
    func bindWork(handler: @escaping (Work?) -> Void) {
        workHandler = handler
    }
    
    func bindIsEdit(handler: @escaping (Bool) -> Void) {
        isEditHandler = handler
    }
    
    init(work: Work? = nil, isEdit: Bool = true) {
        self.work = work
        self.isEdit = isEdit
    }
    
    func load() {
        workHandler?(work)
        isEditHandler?(isEdit)
    }
    
    func toggleEdit() {
        isEdit.toggle()
    }
    
    func updateWork(title: String?, body: String?, date: Date) -> Work? {
        if let work {
            self.work = Work(category: work.category, title: title, body: body, endDate: date)
        } else {
            work = Work(category: .todo, title: title, body: body, endDate: date)
        }
        return work
    }
}
