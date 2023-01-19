//
//  ListCellViewModel.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/13.
//

import Foundation

final class ListCellViewModel {
    
    private var project: Project?
    private var state: ProjectState
    
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
            updateDateDate(date, isMissDeadLine, state)
        }
    }
    
    var updateTitleDate: (String) -> Void = { _ in }
    var updateDescriptionDate: (String) -> Void = { _ in }
    var updateDateDate: (String, Bool, ProjectState) -> Void = { _, _, _ in }
    
    var currentProject: Project? {
        return project
    }
    
    var currentState: ProjectState {
        return state
    }
    
    var isMissDeadLine: Bool {
        let today = Date().changeDotFormatString()
        let deadLine = self.date
        
        return deadLine < today
    }
    
    init(project: Project? = nil, state: ProjectState = .todo) {
        self.project = project
        self.state = state
    }
    
    func setupCell() {
        title = project?.title ?? Default.title
        description = project?.description ?? Default.description
        date = project?.date.changeDotFormatString() ?? Default.date
    }
}

// MARK: - NameSpace
extension ListCellViewModel {
    
    private enum Default {
        
        static let title = ""
        static let description = ""
        static let date = ""
    }
}
