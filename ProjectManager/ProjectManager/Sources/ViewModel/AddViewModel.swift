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
    private weak var delegate: ViewModelDelegate?
    
    func addProject(title: String?, deadline: Date, description: String?) {
        guard let title = title,
              let description = description
        else {
            return
        }
        
        project = Project(title: title, deadline: deadline, description: description, state: .todo)
    }
    
    func setDelegate(_ delegate: ViewModelDelegate) {
        self.delegate = delegate
    }
}
