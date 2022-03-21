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
    var dismissWithTaskUpdate: ((TaskManageViewModel) -> Void)?
    var changeManageTypeToEdit: ((ManageType) -> Void)?
    
    // MARK: - Properties
    private(set) var taskTitle = ""
    private(set) var taskDescription = ""
    private(set) var taskDeadline = Date()
    private(set) var selectedIndex: Int?
    private(set) var selectedTask: Task?
    private(set) var manageType: ManageType
    var navigationTitle: String? {
        return selectedTask?.state.title
    }
    
    init(manageType: ManageType) {
        self.manageType = manageType
    }
    
    convenience init(selectedIndex: Int, selectedTask: Task, manageType: ManageType) {
        self.init(manageType: manageType)
        self.selectedIndex = selectedIndex
        self.selectedTask = selectedTask
        self.taskTitle = selectedTask.title
        self.taskDescription = selectedTask.description
        self.taskDeadline = selectedTask.deadline
    }
    
    private func checkValidInput() -> Bool {
        if taskTitle.isEmpty && taskDescription.isEmpty {
            presentErrorAlert?(TextError.invalidTitleAndDescription)
            return false
        } else if taskTitle.isEmpty {
            presentErrorAlert?(TextError.invalidTitle)
            return false
        } else if taskDescription.isEmpty {
            presentErrorAlert?(TextError.invalidDescription)
            return false
        }
        
        return true
    }
    
    func didTapDoneButton() {
        if checkValidInput() {
            guard let selectedIndex = selectedIndex,
                  let selectedTask = selectedTask else {
                let task = Task(title: taskTitle, description: taskDescription, deadline: taskDeadline)
                dismissWithTaskCreate?(task)
                return
            }
            
            let task = Task(id: selectedTask.id, title: taskTitle, description: taskDescription, deadline: taskDeadline, state: selectedTask.state)
            let taskManageViewModel = TaskManageViewModel(selectedIndex: selectedIndex, selectedTask: task, manageType: manageType)
            dismissWithTaskUpdate?(taskManageViewModel)
        }
    }
    
    func checkValidTextLength(with range: NSRange, length: Int) -> Bool {
        if range.location == length {
            presentErrorAlert?(TextError.outOfBounds(length))
            return false
        }
        if range.length > .zero {
            return true
        }
        
        return range.location < length
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
