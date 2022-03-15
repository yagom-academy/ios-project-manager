//
//  TaskManageViewModel.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/14.
//

import Foundation

class TaskManageViewModel {
    // MARK: - Output
    var dismiss: ((ManageType) -> Void)?
    var changeManageTypeToEdit: ((ManageType) -> Void)?
    
    // MARK: - Properties
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
    }
    
    func checkValidInput(title: String?, description: String?) -> (String, Bool) {
        var invalidItems = [String]()
        if title == "" {
            invalidItems.append("제목")
        }
        
        if description == "" {
            invalidItems.append("내용")
        }
        
        if invalidItems.isEmpty {
            return ("", true)
        }
        return ("\(invalidItems.joined(separator: ", "))을 입력해주세요", false)
    }
    
    func didTapDoneButton() {
        dismiss?(manageType)
    }
    
    func checkValidTextLength(with range: NSRange, length: Int) -> Bool {
        if range.location == length {
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
