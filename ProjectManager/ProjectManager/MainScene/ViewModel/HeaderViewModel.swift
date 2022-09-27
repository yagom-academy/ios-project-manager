//
//  HeaderViewModel.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/19.
//

final class HeaderViewModel {
    let category: String

    init(category: String) {
        self.category = category
    }
    
    func bindListCount(_ completion: @escaping (Int) -> Void) {
        switch category {
        case Category.todo:
            TodoDataManager.shared.todoList.bind { (list) in
                completion(list?.count ?? 0)
            }
        case Category.doing:
            TodoDataManager.shared.doingList.bind { (list) in
                completion(list?.count ?? 0)
            }
        case Category.done:
            TodoDataManager.shared.doneList.bind { (list) in
                completion(list?.count ?? 0)
            }
        default:
            return
        }
    }
}
