//
//  PopoverViewModel.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/19.
//

final class PopoverViewModel {
    let selectedTodo: Todo
    
    init(selectedTodo: Todo) {
        self.selectedTodo = selectedTodo
    }
    
    func move(to target: String) {
        TodoDataManager.shared.move(todo: selectedTodo, to: target)
    }
}
