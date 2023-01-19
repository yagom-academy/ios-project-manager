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
    
    func fetchText(of item: ProjectTextItem) -> String {
        switch item {
        case .title:
            return project.title
        case .description:
            return project.description
        }
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
