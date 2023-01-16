//
//  ProjectViewModel.swift
//  ProjectManager
//
//  Created by junho lee on 2023/01/16.
//

import Foundation

struct ProjectViewModel {
    var project: Project
    var editingProject: Project

    init(project: Project = Project(title: "", description: "", dueDate: Date())) {
        self.project = project
        self.editingProject = project
    }
}
