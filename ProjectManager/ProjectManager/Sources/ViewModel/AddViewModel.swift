//
//  AddViewModel.swift
//  ProjectManager
//
//  Created by Hamo, Wonbi on 2023/01/20.
//

import Foundation

final class AddViewModel {
    private var project: Project? {
        didSet {
            delegate?.addProject(project)
        }
    }
    
    weak var delegate: ViewModelDelegate?
    
    func addProject(title: String, deadline: Calendar, description: String) {
        project = Project(title: title, deadline: deadline, description: description, state: .todo)
    }
}
