//
//  EditingViewModel.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/14.
//

import Foundation

class EditingViewModel {
    
    let editTargetModel: MainViewModel
    let isNewProject: Bool
    let process: Process
    var project: Project = Project(title: nil, description: nil, date: Date())
   
    init(editTargetModel: MainViewModel, isNewProject: Bool = true, process: Process = .todo) {
        self.editTargetModel = editTargetModel
        self.process = process
        self.isNewProject = isNewProject
    }
    
    var processTitle: String {
        return process.title
    }

    func doneEditing(titleInput: String?, descriptionInput: String?, dateInput: Date) {
        project = Project(title: titleInput, description: descriptionInput, date: dateInput)
        isNewProject ? registerProject(project) : editProject()
    }
    
    func registerProject(_ project: Project) {
        editTargetModel.todoData.append(project)
    }
    
    func editProject() {
        print("수정")
    }
}
