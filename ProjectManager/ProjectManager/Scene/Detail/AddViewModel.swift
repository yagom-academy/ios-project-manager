//
//  DetailViewModel.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/13.
//

import Foundation
import RxRelay

protocol AddViewModelable: AddViewModelOutput, AddViewModelInput {}

protocol AddViewModelOutput {
    var list: ListItem { get }
    var dismiss: BehaviorRelay<Void> { get }
}

protocol AddViewModelInput {
    func changeTitle(_ text: String?)
    func changeDaedLine(_ date: Date?)
    func changeBody(_ text: String?)
    func touchCloseButton()
    func touchDoneButton()
}

final class AddViewModel: AddViewModelable {
    private let storage: Storegeable
    
    var list: ListItem
    var dismiss = BehaviorRelay<Void>(value: ())
    
    init(storage: Storegeable) {
        self.storage = storage
        self.list = ListItem(title: "", body: "", deadline: Date(), id: UUID().uuidString)
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
    
    func touchCloseButton() {
        dismiss.accept(())
    }
    
    func touchDoneButton() {
        storage.creatList(listItem: list)
        dismiss.accept(())
    }
}
