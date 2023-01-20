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
            workHandler?(work)
        }
    }
    
    var isEdit: Bool = true {
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
    
    func reloadWork() {
        if work != nil {
            workHandler?(work)
        }
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
