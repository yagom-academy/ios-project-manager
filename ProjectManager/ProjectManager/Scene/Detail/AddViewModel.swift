//
//  DetailViewModel.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/13.
//

import RxRelay

protocol AddViewModelable: AddViewModelOutput, AddViewModelInput {}

protocol AddViewModelOutput {
    var list: ListItem { get }
    var dismiss: PublishRelay<Void> { get }
    var showErrorAlert: PublishRelay<String?> { get }
}

protocol AddViewModelInput {
    func changeTitle(_ text: String?)
    func changeDaedLine(_ date: Date?)
    func changeBody(_ text: String?)
    func touchCloseButton()
    func touchDoneButton()
}

final class AddViewModel: AddViewModelable {
    private let storage: AppStoregeable
    
    var list: ListItem
    var dismiss = PublishRelay<Void>()
    var showErrorAlert = PublishRelay<String?>()
    
    init(storage: AppStoregeable) {
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
        do {
            try storage.creatItem(listItem: list)
            try storage.makeHistory(title: "Added '\(list.title)'.")
            dismiss.accept(())
        } catch {
            guard let error = error as? StorageError else {
                showErrorAlert.accept(nil)
                return
            }
            showErrorAlert.accept(error.errorDescription)
        }
    }
}
