//
//  DefaultDetailUseCase.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/17.
//

import Foundation

final class DefaultDetailUseCase: DetailUseCase {
    
    private let project: Project
    
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
    
    func validateDescription(text: String) -> Bool {
        return text.count <= 1000
    }
}
