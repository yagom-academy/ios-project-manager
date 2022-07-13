//
//  TodoCellViewModel.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/13.
//

import Foundation
import Combine

protocol TodoCellViewModelInput {
    func cellDidBind()
}

protocol TodoCellViewModelOutput {
    var item: Just<TodoListModel> { get }
    var expired: PassthroughSubject<Void, Never> { get }
    var notExpired: PassthroughSubject<Void, Never> { get }
}

protocol TodoCellViewModelable: TodoCellViewModelInput, TodoCellViewModelOutput {}

final class TodoCellViewModel: TodoCellViewModelable {
    private let model: TodoListModel
    
    // MARK: - Output
    
    var item: Just<TodoListModel> {
        return Just(model)
    }
    
    let expired = PassthroughSubject<Void, Never>()
    let notExpired = PassthroughSubject<Void, Never>()
    
    init(_ model: TodoListModel) {
        self.model = model
    }
    
    private func setDateLabelColor() {
        if Date() > model.deadLine {
            expired.send(())
        } else {
            notExpired.send(())
        }
    }
}

extension TodoCellViewModel {
    // MARK: - Input
    
    func cellDidBind() {
        setDateLabelColor()
    }
}
