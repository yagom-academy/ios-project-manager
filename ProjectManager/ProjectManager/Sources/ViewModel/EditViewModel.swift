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
    private var id: UUID?
    private var title: String? {
        didSet {
            titleHandler?(title)
        }
    }
    private var deadline: Date? {
        didSet {
            guard let deadline = deadline else { return }
            deadlineHandler?(deadline)
        }
    }
    private var description: String? {
        didSet {
            descriptionHandler?(description)
        }
    }
    private var state: State? {
        didSet {
            stateHandler?(state?.name)
        }
    }
    private weak var delegate: ViewModelDelegate?
    
    var editingHandler: (() -> Void)?
    var titleHandler: ((String?) -> Void)?
    var deadlineHandler: ((Date) -> Void)?
    var descriptionHandler: ((String?) -> Void)?
    var stateHandler: ((String?) -> Void)?
    
    func setDelegate(_ delegate: ViewModelDelegate) {
        self.delegate = delegate
    }
    
    func changeEditMode(_ state: Bool) {
        isEditing = state
    }
    
    func setProject(_ project: Project) {
        id = project.id
        title = project.title
        deadline = project.deadline
        description = project.description
        state = project.state
    }
    
    func updateProject(title: String?, deadline: Date, description: String?) {
        guard let id = id,
              let title = title,
              let state = state,
              let description = description
        else {
            return
        }
        
        let project = Project(id: id, title: title, deadline: deadline, description: description, state: state)
        delegate?.updateProject(project)
    }
}
