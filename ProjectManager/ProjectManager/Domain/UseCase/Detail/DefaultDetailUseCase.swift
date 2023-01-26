//
//  DefaultDetailUseCase.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/17.
//

import Foundation

final class DefaultDetailUseCase: DetailUseCase {
    
    typealias Number = Constant.Number
    
    private let project: Project
    var state: State {
        return project.state
    }
    
    init(project: Project) {
        self.project = project
    }
    
    func fetchTitleText() -> String {
        return project.title
    }
    
    func fetchDescriptionText() -> String {
        return project.description
    }
    
    func fetchDeadline() -> Date {
        return project.deadline
    }
    
    func fetchIdentifier() -> UUID {
        return project.identifier
    }
    
    func isValidateDescription(text: String) -> Bool {
        return text.count <= Number.descriptionLimit
    }
    
    func isValidateDeadline(date: Date) -> Bool {
        return date.isOverdue == false
    }
}
