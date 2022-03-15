//
//  TaskManageViewModel.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/14.
//

import Foundation

class TaskManageViewModel {
    // MARK: - Output
    var presentErrorAlert: ((Error) -> Void)?
    var dismiss: ((ManageType) -> Void)?
    var changeManageTypeToEdit: ((ManageType) -> Void)?
    
    // MARK: - Properties
    var taskTitle = ""
    var taskDescription = ""
    var taskDeadline = Date()
    var selectedIndex: Int?
    var selectedTask: Task?
    var manageType: ManageType
    
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
            dismiss?(manageType)
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
}
