//
//  PopoverViewModel.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/12.
//

import Foundation

class PopoverViewModel {
    var todoListViewModel: TodoListViewModel?
    var selectedCategory: Category?
    var selectedItem: TodoModel?
    var didChanged: (() -> Void)?
    
    init(viewModel: TodoListViewModel, category: Category?, item: TodoModel) {
        self.todoListViewModel = viewModel
        self.selectedCategory = category
        self.selectedItem = item
    }
    
    func changeCategory(with view: ListCollectionView) {
        selectedCategory = view.category
        didChanged?()
    }
    
    func move(to target: Category) {
        guard var selectedItem = selectedItem else { return }
        todoListViewModel?.delete(model: selectedItem)
        selectedItem.category = target
        todoListViewModel?.create(with: selectedItem)
    }
}
