//
//  ProjectTodoViewModel.swift
//  ProjectManager
//
//  Created by junho lee on 2023/01/16.
//

import Foundation

final class ProjectTodoViewModel {
    var projectTodo: ProjectTodo
    var editingProjectTodo: ProjectTodo

    init(projectTodo: ProjectTodo = ProjectTodo(title: "", description: "", dueDate: Date())) {
        self.projectTodo = projectTodo
        self.editingProjectTodo = projectTodo
    }
}
