//
//  TaskManageViewModel.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/14.
//

import Foundation

final class TaskManageViewModel {
    // MARK: - Output
    var presentErrorAlert: ((Error) -> Void)?
    var dismissWithTaskCreate: ((Task) -> Void)?
    var dismissWithTaskUpdate: ((SelectedTaskViewModel) -> Void)?
    var changeManageTypeToEdit: ((ManageType) -> Void)?
    
    // MARK: - Properties
    private(set) var taskTitle = ""
    private(set) var taskDescription = ""
    private(set) var taskDeadline = Date()
    private(set) var selectedIndex: Int?
    private(set) var selectedTask: Task?
    private(set) var manageType: ManageType
    private let taskManageUseCase: TaskManageUseCase
    var navigationTitle: String? {
        return selectedTask?.state.title
    }
    
    init(manageType: ManageType, taskManageUseCase: TaskManageUseCase) {
        self.manageType = manageType
        self.taskManageUseCase = taskManageUseCase
    }
    
    convenience init(selectedIndex: Int, selectedTask: Task, manageType: ManageType, taskManageUseCase: TaskManageUseCase) {
        self.init(manageType: manageType, taskManageUseCase: taskManageUseCase)
        self.selectedIndex = selectedIndex
        self.selectedTask = selectedTask
        self.taskTitle = selectedTask.title
        self.taskDescription = selectedTask.description
        self.taskDeadline = selectedTask.deadline
    }
    
    private func dismissWithTask() {
        guard let selectedIndex = selectedIndex,
              let selectedTask = selectedTask else {
            let task = Task(title: taskTitle, description: taskDescription, deadline: taskDeadline)
            dismissWithTaskCreate?(task)
            return
        }
        
        let task = Task(id: selectedTask.id, title: taskTitle, description: taskDescription, deadline: taskDeadline, state: selectedTask.state)
        let selectedTaskViewModel = SelectedTaskViewModel(index: selectedIndex, task: task, manageType: manageType)
        dismissWithTaskUpdate?(selectedTaskViewModel)
    }
    
    func didTapDoneButton() {
        let result = taskManageUseCase.checkValidInput(title: taskTitle, description: taskDescription)
        
        switch result {
        case .success:
            dismissWithTask()
        case .failure(let error):
            presentErrorAlert?(error)            
        }
    }
    
    func checkValidTextLength(with range: NSRange, length: Int) -> Bool {
        let isValid = taskManageUseCase.checkValidTextLength(with: range, length: length)
        
        if !isValid {
            presentErrorAlert?(TextError.outOfBounds(length))
        }
        
        return isValid
    }
    
    func changeToEditState() {
        changeManageTypeToEdit?(.edit)
    }
    
    func updateTaskDeadline(with date: Date) {
        taskDeadline = date
    }
    
    func updateTaskTitle(with title: String) {
        taskTitle = title
    }
    
    func updateTaskDescription(with description: String) {
        taskDescription = description
    }
}
