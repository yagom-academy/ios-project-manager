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
    
    private var title: String = Default.title {
        didSet {
            updateTitleDate(title)
        }
    }
    
    private var description: String = Default.description {
        didSet {
            updateDescriptionDate(description)
        }
    }
    
    private var date: String = Default.date {
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
        let today = Date().changeDotFormatString()
        let deadLine = self.date
        
        return deadLine < today
    }
    
    init(project: Project? = nil, process: Process = .todo) {
        self.project = project
        self.process = process
    }
    
    func setupCell() {
        title = project?.title ?? Default.title
        description = project?.description ?? Default.description
        date = project?.date.changeDotFormatString() ?? Default.date
    }
}

extension ListCellViewModel {
    
    private enum Default {
        
        static let title = ""
        static let description = ""
        static let date = ""
    }
}
