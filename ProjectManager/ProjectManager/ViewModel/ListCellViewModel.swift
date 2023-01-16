//
//  ListCellViewModel.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/13.
//

import Foundation

struct ListCellViewModel {
    
    var project: Project?
    var process: Process
    var title: String = "" {
        didSet {
            updateTitleDate(title)
        }
    }
    var description: String = "" {
        didSet {
            updateDescriptionDate(description)
        }
    }
    var date: String = "" {
        didSet {
            updateDateDate(date, isMissDeadLine, process)
        }
    }
    
    var updateTitleDate: (String) -> Void = { _ in }
    var updateDescriptionDate: (String) -> Void = { _ in }
    var updateDateDate: (String, Bool, Process) -> Void = { _, _, _ in }
    
    var isMissDeadLine: Bool {
        let today = Date()
        guard let deadLine = self.date.changeDateFromDotFormat() else { return false }
        
        return deadLine < today
    }
    
    mutating func setupCell(project: Project, in process: Process) {
        title = project.title ?? ""
        description = project.description ?? ""
        date = project.date.changeDotFormatString() 
        self.process = process
        self.project = project
    }
}
