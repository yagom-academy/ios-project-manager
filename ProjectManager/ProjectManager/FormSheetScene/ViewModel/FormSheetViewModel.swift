//
//  CreateTodoListViewModel.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/19.
//

import Foundation

final class FormSheetViewModel {
    let mode: PageMode
    private(set) var currentTodo: Todo?
    
    init(mode: PageMode, category: String?, index: Int?) {
        self.mode = mode
        guard let category = category,
              let index = index else {
            return
        }
        self.currentTodo = TodoDataManager.shared.read(category: category)[index]
    }
    
    func edit(to nextTodo: TodoModel) {
        guard let currentTodo = currentTodo else {
            return
        }
        TodoDataManager.shared.update(todo: currentTodo, with: nextTodo)
    }
    
    func create(_ todoModel: TodoModel) {
        TodoDataManager.shared.create(with: todoModel)
    }
}
