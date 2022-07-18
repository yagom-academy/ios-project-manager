//
//  EditViewModel.swift
//  ProjectManager
//
//  Created by 최최성균 on 2022/07/16.
//

import Foundation
import RxRelay
protocol EditViewModelable: EditViewModelOutput, EditViewModelInput {
    var isEditable: BehaviorRelay<Bool> { get }
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
    var isEditable = BehaviorRelay<Bool>(value: false)
    
    init(storage: Storegeable, index: Int, type: ListType) {
        self.storage = storage
        self.list = storage.selectList(index: index, type: type)
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
        if isEditable.value {
            vc.dismiss(animated: true)
            return nil
        } else {
            self.isEditable.accept(true)
            return "Cancel"
        }
    }
    
    func touchDoneButton() {
        storage.updateList(listItem: list)
    }
}
