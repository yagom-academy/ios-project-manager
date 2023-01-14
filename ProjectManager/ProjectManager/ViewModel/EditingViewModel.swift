//
//  EditingViewModel.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/14.
//

import Foundation

class EditingViewModel {
    
    var project: Project = Project(title: "", description: "", date: Date()) {
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
         isNewProject: Bool = true,
         process: Process = .todo) {
        self.editTargetModel = editTargetModel
        self.process = process
        self.isNewProject = isNewProject
    }

    func doneEditing(titleInput: String?, descriptionInput: String?, dateInput: Date) {
        project = Project(title: titleInput, description: descriptionInput, date: dateInput)
        isNewProject ? registerProject(project) : editProject()
    }
    
    func registerProject(_ project: Project) {
        editTargetModel.registerProject(project, in: .todo)
    }
    
    func editProject() {
        print("수정")
    }
}
