//
//  HeaderViewModel.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/19.
//

final class HeaderViewModel {
    let category: String
    private(set) var count: Int = 0 {
        didSet {
            didChangedCount?()
        }
    }
    
    var didChangedCount: (() -> Void)?
    
    init(category: String) {
        self.category = category
        bind(at: category)
    }
    
    func bind(at category: String) {
        switch category {
        case Category.todo:
            TodoDataManager.shared.todoList.bind { [weak self] (list) in
                self?.count = list?.count ?? 0
            }
        case Category.doing:
            TodoDataManager.shared.doingList.bind { [weak self] (list) in
                self?.count = list?.count ?? 0
            }
        case Category.done:
            TodoDataManager.shared.doneList.bind { [weak self] (list) in
                self?.count = list?.count ?? 0
            }
        default:
            return
        }
    }
}
