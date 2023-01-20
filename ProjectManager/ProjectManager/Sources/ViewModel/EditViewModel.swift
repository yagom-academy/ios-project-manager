//
//  EditViewModel.swift
//  ProjectManager
//
//  Created by Hamo, Wonbi on 2023/01/19.
//

import Foundation

final class EditViewModel {
    struct ViewProject {
        let title: String?
        let deadline: Calendar?
        let description: String?
        
        init(title: String? = nil, deadline: Calendar? = nil, description: String? = nil) {
            self.title = title
            self.deadline = deadline
            self.description = description
        }
    }
    
    private var isEditing: Bool? {
        didSet {
            editingHandler?()
        }
    }
    
    private var viewProject: ViewProject = ViewProject() {
        didSet {
            componentsHandler?(viewProject)
        }
    }
    
    var editingHandler: (() -> Void)?
    var componentsHandler: ((ViewProject) -> Void)?
    
    func changeEditMode(_ state: Bool) {
        isEditing = state
    }
    
    func setupProject(_ project: Project) {
        let viewProject = ViewProject(
            title: project.title,
            deadline: project.deadline,
            description: project.description
        )
        
        self.viewProject = viewProject
    }
}
