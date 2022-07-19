//
//  EditViewModel.swift
//  ProjectManager
//
//  Created by 최최성균 on 2022/07/16.
//

import Foundation
import RxRelay
protocol EditViewModelable: EditViewModelOutput, EditViewModelInput {}

protocol EditViewModelOutput {
    var list: ListItem { get }
    var isEditable: BehaviorRelay<Bool> { get }
    var dismiss: BehaviorRelay<Void> { get }
}

protocol EditViewModelInput {
    func changeTitle(_ text: String?)
    func changeDaedLine(_ date: Date?)
    func changeBody(_ text: String?)
    func touchLeftButton()
    func touchDoneButton()
}

final class EditViewModel: EditViewModelable {
    private let storage: Storegeable
    
    //out
    var list: ListItem
    var isEditable = BehaviorRelay<Bool>(value: false)
    var dismiss = BehaviorRelay<Void>(value: ())
    
    init(storage: Storegeable, item: ListItem) {
        self.storage = storage
        self.list = item
    }
    
    //in
    func changeTitle(_ text: String?) {
        list.title = text ?? ""
    }
    
    func changeDaedLine(_ date: Date?) {
        list.deadline = date ?? Date()
    }
    
    func changeBody(_ text: String?) {
        list.body = text ?? ""
    }
    
    func touchLeftButton() {
        if isEditable.value {
            self.dismiss.accept(())
        } else {
            self.isEditable.accept(true)
        }
    }
    
    func touchDoneButton() {
        storage.updateList(listItem: list)
        dismiss.accept(())
    }
}
