//
//  EditingViewModel.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/14.
//

import Foundation

class EditingViewModel {
    
    var project: Project {
        didSet {
            updateData(project)
        }
    }
    let editTargetModel: MainViewModel
    let isNewProject: Bool
    let process: Process

    var processTitle: String {
        return process.title
    }
    
    var updateData: (Project) -> Void = { _ in }
    
    init(editTargetModel: MainViewModel,
         project: Project,
         isNewProject: Bool = true,
         process: Process = .todo) {
        self.project = project
        self.editTargetModel = editTargetModel
        self.process = process
        self.isNewProject = isNewProject
    }

    func doneEditing(titleInput: String?, descriptionInput: String?, dateInput: Date) {
        project.title = titleInput
        project.description = descriptionInput
        project.date = dateInput
        
        isNewProject ? registerProject(project) : editProject(project)
    }
    
    func registerProject(_ project: Project) {
        editTargetModel.registerProject(project, in: .todo)
    }
    
    func editProject(_ project: Project) {
        editTargetModel.editProject(project, in: process)
    }
}
