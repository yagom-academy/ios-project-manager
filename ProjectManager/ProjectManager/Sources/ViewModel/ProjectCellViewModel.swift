//
//  ProjectCellViewModel.swift
//  ProjectManager
//
//  Created by Hamo, Wonbi on 2023/01/20.
//

import Foundation

final class ProjectCellViewModel {
    typealias DeadLine = (date: String?, color: DateColor)
    
    private var title: String? {
        didSet {
            titleHandler?(title)
        }
    }
    private var deadline: DeadLine? {
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
    var deadlineHandler: ((DeadLine?) -> Void)?
    var descriptionHandler: ((String?) -> Void)?
    
    func makeCellData(_ project: Project) {
        title = project.title
        description = project.description
        deadline = (project.deadline.convertString(), Date() > project.deadline ? .red : .black)
    }
}
