//
//  EditViewModel.swift
//  ProjectManager
//
//  Created by 최최성균 on 2022/07/16.
//

import Foundation
protocol EditViewModelable: EditViewModelOutput, EditViewModelInput {
    var isEditable: Bool { get }
}

protocol EditViewModelOutput {
    var list: ListItem { get }
}

protocol EditViewModelInput {
    func changeTitle(_ text: String?)
    func changeDaedLine(_ date: Date?)
    func changeBody(_ text: String?)
    func touchDoneButton()
}

final class EditViewModel: EditViewModelable {
    private let storage: Storegeable
    var list: ListItem
    var isEditable: Bool
    
    init(storage: Storegeable, list: ListItem?) {
        self.storage = storage
        self.list = list ?? ListItem(title: "", body: "", deadline: Date())
        self.isEditable = false
    }
    
    func changeTitle(_ text: String?) {
        list.title = text ?? ""
    }
    
    func changeDaedLine(_ date: Date?) {
        list.deadline = date ?? Date()
    }
    
    func changeBody(_ text: String?) {
        list.body = text ?? ""
    }
    
    func touchLeftButton(_ vc: EditViewController) -> String? {
        if isEditable {
            vc.dismiss(animated: true)
            return nil
        } else {
            self.isEditable = true
            return "Cancel"
        }
    }
    
    func touchDoneButton() {
        storage.updateList(listItem: list)
    }
}
