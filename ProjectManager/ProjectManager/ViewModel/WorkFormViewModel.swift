//
//  WorkFormViewModel.swift
//  ProjectManager
//
//  Created by leewonseok on 2023/01/17.
//

import Foundation

final class WorkFormViewModel {
    var work: Work?
    
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
