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
            view.countLabel.text = " \(TodoDataManager.shared.todoList.value!.count) "
        case Category.doing:
            view.countLabel.text = " \(TodoDataManager.shared.doingList.value!.count) "
        case Category.done:
            view.countLabel.text = " \(TodoDataManager.shared.doneList.value!.count) "
        default:
            return
        }
    }
}
