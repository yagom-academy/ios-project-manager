//
//  DetailViewModel.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/13.
//

import Foundation

protocol DetailViewModelable: AddViewModelOutput, AddViewModelInput {}

protocol AddViewModelOutput {
    var list: ListItem { get }
}

protocol AddViewModelInput {
    func changeTitle(_ text: String?)
    func changeDaedLine(_ date: Date?)
    func changeBody(_ text: String?)
    func touchDoneButton()
}

final class AddViewModel: DetailViewModelable {
    private let storage: Storegeable
    var list: ListItem
    
    init(storage: Storegeable) {
        self.storage = storage
        self.list = ListItem(title: "", body: "", deadline: Date())
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
        storage.creatList(listItem: list)
    }
}
