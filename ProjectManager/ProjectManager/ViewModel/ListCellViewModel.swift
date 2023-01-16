//
//  ListCellViewModel.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/13.
//

import Foundation

final class ListCellViewModel {
    
    private var project: Project?
    private var process: Process
    
    private var title: String = "" {
        didSet {
            updateTitleDate(title)
        }
    }
    
    private var description: String = "" {
        didSet {
            updateDescriptionDate(description)
        }
    }
    
    private var date: String = "" {
        didSet {
            updateDateDate(date, isMissDeadLine, process)
        }
    }
    
    var updateTitleDate: (String) -> Void = { _ in }
    var updateDescriptionDate: (String) -> Void = { _ in }
    var updateDateDate: (String, Bool, Process) -> Void = { _, _, _ in }
    
    var currentProject: Project? {
        return project
    }
    
    var currentProcess: Process {
        return process
    }
    
    var isMissDeadLine: Bool {
        let today = Date()
        guard let deadLine = self.date.changeDateFromDotFormat() else { return false }
        
        return deadLine < today
    }
    
    init(project: Project? = nil, process: Process = .todo) {
        self.project = project
        self.process = process
    }
    
    func setupCell() {
        title = project?.title ?? ""
        description = project?.description ?? ""
        date = project?.date.changeDotFormatString() ?? ""
    }
}
