//
//  ListCollectionViewModel.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/19.
//

final class ListCollectionViewModel {
    private var category: String
    var list: [Todo]? = [] {
        didSet {
            didMovedList.forEach { $0?(list) }
        }
    }
    var didMovedList: [(([Todo]?) -> Void)?] = []
    var performAdd: [((Todo) -> Void)?] = []
    var performDelete: [((Todo) -> Void)?] = []
    
    init(category: String) {
        self.category = category
        bindData(at: category)
        bindUpdateBehavior()
    }
    
    private func bindData(at category: String) {
        switch category {
        case Category.todo:
            TodoDataManager.shared.todoList.bind { [weak self] (todoList) in
                self?.list = todoList
            }
        case Category.doing:
            TodoDataManager.shared.doingList.bind { [weak self] (doingList) in
                self?.list = doingList
            }
        case Category.done:
            TodoDataManager.shared.doneList.bind { [weak self] (doneList) in
                self?.list = doneList
            }
        default:
            return
        }
    }
    
    private func bindUpdateBehavior() {
        TodoDataManager.shared.willAppendItem.append({ [weak self] (todo) in
            self?.performAdd.forEach { $0?(todo) }
        })
        TodoDataManager.shared.willDeleteItem.append({ [weak self] (todo) in
            self?.performDelete.forEach { $0?(todo) }
        })
    }
}
