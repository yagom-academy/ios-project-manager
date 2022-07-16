//
//  EditViewModel.swift
//  ProjectManager
//
//  Created by 최최성균 on 2022/07/16.
//

import Foundation

final class EditViewModel: DetailViewModelable {
    private let storage: Storegeable
    var list: ListItem
    
    init(storage: Storegeable, list: ListItem?) {
        self.storage = storage
        self.list = list ?? ListItem(title: "", body: "", deadline: Date())
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
    
    func touchDoneButton() {
        storage.updateList(listItem: list)
    }
}
