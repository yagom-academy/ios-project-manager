//
//  ProjectCellViewModel.swift
//  ProjectManager
//
//  Created by Hamo, Wonbi on 2023/01/20.
//

import Foundation

final class ProjectCellViewModel {
    private var title: String? {
        didSet {
            titleHandler?(title)
        }
    }
    private var deadline: String? {
        didSet {
            deadlineHandler?(deadline)
        }
    }
    
    private var description: String? {
        didSet {
            descriptionHandler?(description)
        }
    }
    
    var titleHandler: ((String?) -> Void)?
    var deadlineHandler: ((String?) -> Void)?
    var descriptionHandler: ((String?) -> Void)?
    
    func makeCellData(_ project: Project) {
        title = project.title
        deadline = project.deadline.description
        description = project.description
    }
}
