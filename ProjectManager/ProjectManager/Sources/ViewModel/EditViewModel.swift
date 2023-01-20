//
//  EditViewModel.swift
//  ProjectManager
//
//  Created by Hamo, Wonbi on 2023/01/19.
//

import Foundation

final class EditViewModel {
    private var isEditing: Bool? {
        didSet {
            editingHandler?()
        }
    }
    
    private var project: Project? {
        didSet {
            componentsHandler?(project)
        }
    }
    
    var editingHandler: (() -> Void)?
    var componentsHandler: ((Project?) -> Void)?
    weak var delegate: ViewModelDelegate?
    
    func changeEditMode(_ state: Bool) {
        isEditing = state
    }
    
    func setupProject(_ project: Project) {
        self.project = project
    }
    
    func updateProject(title: String, deadline: Calendar, description: String) {
        project?.title = title
        project?.deadline = deadline
        project?.description = description
        
        delegate?.updateProject(project)
    }
}
