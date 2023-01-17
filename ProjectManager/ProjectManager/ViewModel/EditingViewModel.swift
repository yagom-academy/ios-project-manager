//
//  EditingViewModel.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/14.
//

import Foundation

final class EditingViewModel {
    
    private var project: Project
    private let editTargetModel: MainViewModel
    private let isNewProject: Bool
    private let process: Process
    
    private var mode: EditingMode = .editable {
        didSet {
            changeMode()
        }
    }
    
    private var title: String = Default.title {
        didSet {
            updateTitle(title)
        }
    }
    
    private var date: Date = Date() {
        didSet {
            updateDate(date)
        }
    }
    
    private var description: String = Default.description {
        didSet {
            updateDescription(description)
        }
    }
    
    var barTitle: String {
        return process.title
    }
    
    var leftBarOptionTitle: String {
        return mode.barOptionTitle.left
    }
    
    var rightBarOptionTitle: String {
        return mode.barOptionTitle.right
    }
    
    var isEditable: Bool {
        return mode == .editable
    }
    
    var changeMode: () -> Void = { }
    var updateTitle: (String) -> Void = { _ in }
    var updateDate: (Date) -> Void = { _ in }
    var updateDescription: (String) -> Void = { _ in }
    
    init(editTargetModel: MainViewModel,
         project: Project,
         isNewProject: Bool = true,
         process: Process = .todo) {
        self.project = project
        self.editTargetModel = editTargetModel
        self.process = process
        self.isNewProject = isNewProject
    }
    
    func initialSetupView() {
        self.title = project.title ?? Default.title
        self.date = project.date
        self.description = project.description ?? Default.description
        if !isNewProject {
            mode = .readOnly
        }
    }
    
    func doneEditing(titleInput: String?, descriptionInput: String?, dateInput: Date) {
        project.title = titleInput
        project.description = descriptionInput
        project.date = dateInput
        
        isNewProject ? registerProject(project) : editProject(project)
    }
    
    func changeModeToEditable() {
        self.mode = .editable
    }
    
    func registerProject(_ project: Project) {
        editTargetModel.registerProject(project, in: .todo)
    }
    
    func editProject(_ project: Project) {
        editTargetModel.editProject(project, in: process)
    }
}

extension EditingViewModel {
    
    private enum EditingMode {
        case editable
        case readOnly
        
        var barOptionTitle: (left: String, right: String) {
            switch self {
            case .editable:
                return (left: Title.Cancel, right: Title.Done)
            case .readOnly:
                return (left: Title.Edit, right: Title.Done)
            }
        }
    }
}

// MARK: - NameSpace
extension EditingViewModel {
    
    private enum Default {
        
        static let title = ""
        static let description = ""
    }
    
    private enum Title {
        
        static let Cancel = "Cancel"
        static let Done = "Done"
        static let Edit = "Edit"
    }
}
