//
//  HeaderViewModel.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/19.
//

final class HeaderViewModel {
    private let title: String
    var didChangedCount: (() -> Void)?
    
    init(category: String) {
        self.title = category
        bind(at: category)
    }
    
    func bind(at category: String) {
        switch category {
        case Category.todo:
            TodoDataManager.shared.todoList.bind { [weak self] _ in
                self?.didChangedCount?()
            }
        case Category.doing:
            TodoDataManager.shared.doingList.bind { [weak self] _ in
                self?.didChangedCount?()
            }
        case Category.done:
            TodoDataManager.shared.doneList.bind { [weak self] _ in
                self?.didChangedCount?()
            }
        default:
            return
        }
    }
    
    func configure(_ view: HeaderView) {
        view.categoryLabel.text = title
        switch title {
        case Category.todo:
            let todoListCount = TodoDataManager.shared.todoList.value?.count ?? 0
            view.countLabel.text = " \(todoListCount) "
        case Category.doing:
            let doingListCount = TodoDataManager.shared.doingList.value?.count ?? 0
            view.countLabel.text = " \(doingListCount) "
        case Category.done:
            let doneListCount = TodoDataManager.shared.doneList.value?.count ?? 0
            view.countLabel.text = " \(doneListCount) "
        default:
            return
        }
    }
}
