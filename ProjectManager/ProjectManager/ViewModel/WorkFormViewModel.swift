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
        if work == nil {
            work = Work(category: .todo, endDate: date)
        }
        work?.title = title
        work?.body = body
        work?.endDate = date
        return work
    }
    
}
