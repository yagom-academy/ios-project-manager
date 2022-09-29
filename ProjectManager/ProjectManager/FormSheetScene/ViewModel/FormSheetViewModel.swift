//
//  CreateTodoListViewModel.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/19.
//

final class FormSheetViewModel {
    let mode: PageMode
    var currentTodo: Todo?
    
    init(mode: PageMode, category: String?, index: Int?) {
        self.mode = mode
        guard let category = category,
              let index = index else {
            return
        }
        self.currentTodo = TodoDataManager.shared.read(category: category)[index]
    }
    
    func edit(to nextTodo: Todo) {
        guard let currentTodo = currentTodo else {
            return
        }
        TodoDataManager.shared.update(todo: currentTodo, with: nextTodo)
    }
    
    func create(_ todo: Todo) {
        TodoDataManager.shared.create(with: todo)
    }
}
