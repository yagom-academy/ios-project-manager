//
//  ListCollectionViewModel.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/19.
//

final class ListCollectionViewModel {
    var category: String
    var list: [Todo] = [] {
        didSet {
            didUpdatedList?(list)
        }
    }
    var didUpdatedList: (([Todo]) -> Void)?
    init(category: String) {
        self.category = category
        bind(at: category)
    }
    
    func bind(at category: String) {
        switch category {
        case Category.todo:
            TodoDataManager.shared.todoList.bind { [weak self] (list) in
                self?.list = list ?? []
            }
        case Category.doing:
            TodoDataManager.shared.doingList.bind { [weak self] (list) in
                self?.list = list ?? []
            }
        case Category.done:
            TodoDataManager.shared.doneList.bind { [weak self] (list) in
                self?.list = list ?? []
            }
        default:
            return
        }
    }
    
    func configure(_ view: ListCollectionView) {
        
    }
}
